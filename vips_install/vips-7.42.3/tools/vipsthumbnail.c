/* VIPS thumbnailer
 *
 * 11/1/09
 *
 * 13/1/09
 * 	- decode labq and rad images
 * 	- colour management
 * 	- better handling of tiny images
 * 25/1/10
 * 	- added "--delete"
 * 6/2/10
 * 	- added "--interpolator"
 * 	- added "--nosharpen"
 * 	- better 'open' logic, test lazy flag now
 * 13/5/10
 * 	- oops hehe residual sharpen test was reversed
 * 	- and the mask coefficients were messed up
 * 26/5/10
 * 	- delete failed if there was a profile
 * 4/7/10
 * 	- oops sharpening was turning off for integer shrinks, thanks Nicolas
 * 30/7/10
 * 	- use new "rd" mode rather than our own open via disc
 * 8/2/12
 * 	- use :seq mode for png images
 * 	- shrink to a scanline cache to ensure we request pixels sequentially
 * 	  from the input
 * 13/6/12
 * 	- update the sequential stuff to the general method
 * 21/6/12
 * 	- remove "--nodelete" option, have a --delete option instead, off by
 * 	  default
 * 	- much more gentle extra sharpening
 * 13/11/12
 * 	- allow absolute paths in -o (thanks fuho)
 * 3/5/13
 * 	- add optional sharpening mask from file
 * 10/7/13
 * 	- rewrite for vips8
 * 	- handle embedded jpeg thumbnails
 * 12/11/13
 * 	- add --linear option
 * 18/12/13
 * 	- add --crop option
 * 5/3/14
 * 	- copy main image metadata to embedded thumbnails, thanks ottob
 * 6/3/14
 * 	- add --rotate flag
 * 7/3/14
 * 	- remove the embedded thumbnail reader, embedded thumbnails are too
 * 	  unlike the main image wrt. rotation / colour / etc.
 * 30/6/14
 * 	- fix interlaced thumbnail output, thanks lovell
 * 3/8/14
 * 	- box shrink less, use interpolator more, if window_size is large
 * 	  enough
 * 	- default to bicubic if available
 * 	- add an anti-alias filter between shrink and affine
 * 	- support CMYK
 * 	- use SEQ_UNBUF for a memory saving
 * 12/9/14
 * 	- try with embedded profile first, if that fails retry with fallback
 * 	  profile
 * 13/1/15
 * 	- exit with an error code if one or more conversions failed
 * 20/1/15
 * 	- rename -o as -f, keep -o as a hidden flag
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif /*HAVE_CONFIG_H*/
#include <vips/intl.h>

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <locale.h>

#include <vips/vips.h>
#include <vips/internal.h>

#define ORIENTATION ("exif-ifd0-Orientation")

/* Default settings. We change the default to bicubic in main() if
 * this vips has been compiled with bicubic support.
 */

static char *thumbnail_size = "128";
static int thumbnail_width = 128;
static int thumbnail_height = 128;
static char *output_format = "tn_%s.jpg";
static char *interpolator = "bilinear";
static char *export_profile = NULL;
static char *import_profile = NULL;
static char *convolution_mask = "mild";
static gboolean delete_profile = FALSE;
static gboolean linear_processing = FALSE;
static gboolean crop_image = FALSE;
static gboolean rotate_image = FALSE;

/* Deprecated and unused.
 */
static gboolean nosharpen = FALSE;
static gboolean nodelete_profile = FALSE;
static gboolean verbose = FALSE;

static GOptionEntry options[] = {
	{ "size", 's', 0, 
		G_OPTION_ARG_STRING, &thumbnail_size, 
		N_( "shrink to SIZE or to WIDTHxHEIGHT" ), 
		N_( "SIZE" ) },
	{ "output", 'o', G_OPTION_FLAG_HIDDEN, 
		G_OPTION_ARG_STRING, &output_format, 
		N_( "set output to FORMAT" ), 
		N_( "FORMAT" ) },
	{ "format", 'f', 0, 
		G_OPTION_ARG_STRING, &output_format, 
		N_( "set output format string to FORMAT" ), 
		N_( "FORMAT" ) },
	{ "interpolator", 'p', 0, 
		G_OPTION_ARG_STRING, &interpolator, 
		N_( "resample with INTERPOLATOR" ), 
		N_( "INTERPOLATOR" ) },
	{ "sharpen", 'r', 0, 
		G_OPTION_ARG_STRING, &convolution_mask, 
		N_( "sharpen with none|mild|MASKFILE" ), 
		N_( "none|mild|MASKFILE" ) },
	{ "eprofile", 'e', 0, 
		G_OPTION_ARG_STRING, &export_profile, 
		N_( "export with PROFILE" ), 
		N_( "PROFILE" ) },
	{ "iprofile", 'i', 0, 
		G_OPTION_ARG_STRING, &import_profile, 
		N_( "import untagged images with PROFILE" ), 
		N_( "PROFILE" ) },
	{ "linear", 'a', 0, 
		G_OPTION_ARG_NONE, &linear_processing, 
		N_( "process in linear space" ), NULL },
	{ "crop", 'c', 0, 
		G_OPTION_ARG_NONE, &crop_image, 
		N_( "crop exactly to SIZE" ), NULL },
	{ "rotate", 't', 0, 
		G_OPTION_ARG_NONE, &rotate_image, 
		N_( "auto-rotate" ), NULL },
	{ "delete", 'd', 0, 
		G_OPTION_ARG_NONE, &delete_profile, 
		N_( "delete profile from exported image" ), NULL },
	{ "verbose", 'v', G_OPTION_FLAG_HIDDEN, 
		G_OPTION_ARG_NONE, &verbose, 
		N_( "(deprecated, does nothing)" ), NULL },
	{ "nodelete", 'l', G_OPTION_FLAG_HIDDEN, 
		G_OPTION_ARG_NONE, &nodelete_profile, 
		N_( "(deprecated, does nothing)" ), NULL },
	{ "nosharpen", 'n', G_OPTION_FLAG_HIDDEN, 
		G_OPTION_ARG_NONE, &nosharpen, 
		N_( "(deprecated, does nothing)" ), NULL },
	{ NULL }
};

/* Calculate the shrink factors. 
 *
 * We shrink in two stages: first, a shrink with a block average. This can
 * only accurately shrink by integer factors. We then do a second shrink with
 * a supplied interpolator to get the exact size we want.
 *
 * We aim to do the second shrink by roughly half the interpolator's 
 * window_size.
 */
static int
calculate_shrink( VipsImage *im, double *residual, 
	VipsInterpolate *interp )
{
	VipsAngle angle = vips_autorot_get_angle( im ); 
	gboolean rotate = angle == VIPS_ANGLE_D90 || angle == VIPS_ANGLE_D270;
	int width = rotate_image && rotate ? im->Ysize : im->Xsize;
	int height = rotate_image && rotate ? im->Xsize : im->Ysize;
	const int window_size =
		interp ?  vips_interpolate_get_window_size( interp ) : 2;

	VipsDirection direction;

	/* Calculate the horizontal and vertical shrink we'd need to fit the
	 * image to the bounding box, and pick the biggest.
	 *
	 * In crop mode we aim to fill the bounding box, so we must use the
	 * smaller axis.
	 */
	double horizontal = (double) width / thumbnail_width;
	double vertical = (double) height / thumbnail_height;

	if( crop_image ) {
		if( horizontal < vertical )
			direction = VIPS_DIRECTION_HORIZONTAL;
		else
			direction = VIPS_DIRECTION_VERTICAL;
	}
	else {
		if( horizontal < vertical )
			direction = VIPS_DIRECTION_VERTICAL;
		else
			direction = VIPS_DIRECTION_HORIZONTAL;
	}

	double factor = direction == VIPS_DIRECTION_HORIZONTAL ?
		horizontal : vertical; 

	/* If the shrink factor is <= 1.0, we need to zoom rather than shrink.
	 * Just set the factor to 1 in this case.
	 */
	double factor2 = factor < 1.0 ? 1.0 : factor;

	/* Int component of factor2. 
	 *
	 * We want to shrink by less for interpolators with larger windows.
	 */
	int shrink = VIPS_MAX( 1, 
		floor( factor2 ) / VIPS_MAX( 1, window_size / 2 ) );

	if( residual &&
		direction == VIPS_DIRECTION_HORIZONTAL ) {
		/* Size after int shrink. 
		 */
		int iwidth = width / shrink;

		/* Therefore residual scale factor is.
		 */
		double hresidual = (width / factor) / iwidth; 

		*residual = hresidual;
	}
	else if( residual &&
		direction == VIPS_DIRECTION_VERTICAL ) {
		int iheight = height / shrink;
		double vresidual = (height / factor) / iheight; 

		*residual = vresidual;
	}

	return( shrink );
}

/* Find the best jpeg preload shrink.
 */
static int
thumbnail_find_jpegshrink( VipsImage *im )
{
	int shrink = calculate_shrink( im, NULL, NULL );

	/* We can't use pre-shrunk images in linear mode. libjpeg shrinks in Y
	 * (of YCbCR), not linear space.
	 */

	if( linear_processing )
		return( 1 ); 
	else if( shrink >= 8 )
		return( 8 );
	else if( shrink >= 4 )
		return( 4 );
	else if( shrink >= 2 )
		return( 2 );
	else 
		return( 1 );
}

/* Open an image, returning the best version of that image for thumbnailing. 
 *
 * libjpeg supports fast shrink-on-read, so if we have a JPEG, we can ask 
 * VIPS to load a lower resolution version.
 */
static VipsImage *
thumbnail_open( VipsObject *process, const char *filename )
{
	const char *loader;
	VipsImage *im;

	vips_info( "vipsthumbnail", "thumbnailing %s", filename );

	if( linear_processing )
		vips_info( "vipsthumbnail", "linear mode" ); 

	if( !(loader = vips_foreign_find_load( filename )) )
		return( NULL );

	vips_info( "vipsthumbnail", "selected loader is %s", loader ); 

	if( strcmp( loader, "VipsForeignLoadJpegFile" ) == 0 ) {
		int jpegshrink;

		/* This will just read in the header and is quick.
		 */
		if( !(im = vips_image_new_from_file( filename, NULL )) )
			return( NULL );

		jpegshrink = thumbnail_find_jpegshrink( im );

		g_object_unref( im );

		vips_info( "vipsthumbnail", 
			"loading jpeg with factor %d pre-shrink", 
			jpegshrink ); 

		/* We can't use UNBUFERRED safely on very-many-core systems.
		 */
		if( !(im = vips_image_new_from_file( filename, 
			"access", VIPS_ACCESS_SEQUENTIAL,
			"shrink", jpegshrink,
			NULL )) )
			return( NULL );
	}
	else {
		/* All other formats.
		 */
		if( !(im = vips_image_new_from_file( filename, 
			"access", VIPS_ACCESS_SEQUENTIAL,
			NULL )) )
			return( NULL );
	}

	vips_object_local( process, im );

	return( im ); 
}

static VipsInterpolate *
thumbnail_interpolator( VipsObject *process, VipsImage *in )
{
	double residual;
	VipsInterpolate *interp;

	calculate_shrink( in, &residual, NULL );

	/* For images smaller than the thumbnail, we upscale with nearest
	 * neighbor. Otherwise we make thumbnails that look fuzzy and awful.
	 */
	if( !(interp = VIPS_INTERPOLATE( vips_object_new_from_string( 
		g_type_class_ref( VIPS_TYPE_INTERPOLATE ), 
		residual > 1.0 ? "nearest" : interpolator ) )) )
		return( NULL );

	vips_object_local( process, interp );

	return( interp );
}

/* Some interpolators look a little soft, so we have an optional sharpening
 * stage.
 */
static VipsImage *
thumbnail_sharpen( VipsObject *process )
{
	VipsImage *mask;

	if( strcmp( convolution_mask, "none" ) == 0 ) 
		mask = NULL; 
	else if( strcmp( convolution_mask, "mild" ) == 0 ) {
		mask = vips_image_new_matrixv( 3, 3,
			-1.0, -1.0, -1.0,
			-1.0, 32.0, -1.0,
			-1.0, -1.0, -1.0 );
		vips_image_set_double( mask, "scale", 24 );
	}
	else
		if( !(mask = 
			vips_image_new_from_file( convolution_mask, NULL )) )
			vips_error_exit( "unable to load sharpen mask" ); 

	if( mask )
		vips_object_local( process, mask );

	return( mask );
}

static VipsImage *
thumbnail_shrink( VipsObject *process, VipsImage *in, 
	VipsInterpolate *interp, VipsImage *sharpen )
{
	VipsImage **t = (VipsImage **) vips_object_local_array( process, 10 );
	VipsInterpretation interpretation = linear_processing ?
		VIPS_INTERPRETATION_XYZ : VIPS_INTERPRETATION_sRGB; 

	/* TRUE if we've done the import of an ICC transform and still need to
	 * export.
	 */
	gboolean have_imported;

	int shrink; 
	double residual; 
	int tile_width;
	int tile_height;
	int nlines;
	double sigma;

	/* RAD needs special unpacking.
	 */
	if( in->Coding == VIPS_CODING_RAD ) {
		vips_info( "vipsthumbnail", "unpacking Rad to float" );

		/* rad is scrgb.
		 */
		if( vips_rad2float( in, &t[0], NULL ) )
			return( NULL );
		in = t[0];
	}

	/* In linear mode, we import right at the start. 
	 *
	 * We also have to import the whole image if it's CMYK, since
	 * vips_colourspace() (see below) doesn't know about CMYK.
	 *
	 * This is only going to work for images in device space. If you have
	 * an image in PCS which also has an attached profile, strange things
	 * will happen. 
	 */
	have_imported = FALSE;
	if( (linear_processing ||
		in->Type == VIPS_INTERPRETATION_CMYK) &&
		in->Coding == VIPS_CODING_NONE &&
		(in->BandFmt == VIPS_FORMAT_UCHAR ||
		 in->BandFmt == VIPS_FORMAT_USHORT) &&
		(vips_image_get_typeof( in, VIPS_META_ICC_NAME ) || 
		 import_profile) ) {
		if( vips_image_get_typeof( in, VIPS_META_ICC_NAME ) )
			vips_info( "vipsthumbnail", 
				"importing with embedded profile" );
		else
			vips_info( "vipsthumbnail", 
				"importing with profile %s", import_profile );

		if( vips_icc_import( in, &t[1], 
			"input_profile", import_profile,
			"embedded", TRUE,
			"pcs", VIPS_PCS_XYZ,
			NULL ) )  
			return( NULL );

		in = t[1];

		have_imported = TRUE;
	}

	/* To the processing colourspace. This will unpack LABQ as well.
	 */
	vips_info( "vipsthumbnail", "converting to processing space %s",
		vips_enum_nick( VIPS_TYPE_INTERPRETATION, interpretation ) ); 
	if( vips_colourspace( in, &t[2], interpretation, NULL ) ) 
		return( NULL ); 
	in = t[2];

	shrink = calculate_shrink( in, &residual, interp );

	vips_info( "vipsthumbnail", "integer shrink by %d", shrink );

	if( vips_shrink( in, &t[3], shrink, shrink, NULL ) ) 
		return( NULL );
	in = t[3];

	/* We want to make sure we read the image sequentially.
	 * However, the convolution we may be doing later will force us 
	 * into SMALLTILE or maybe FATSTRIP mode and that will break
	 * sequentiality.
	 *
	 * So ... read into a cache where tiles are scanlines, and make sure
	 * we keep enough scanlines to be able to serve a line of tiles.
	 *
	 * We use a threaded tilecache to avoid a deadlock: suppose thread1,
	 * evaluating the top block of the output, is delayed, and thread2, 
	 * evaluating the second block, gets here first (this can happen on 
	 * a heavily-loaded system). 
	 *
	 * With an unthreaded tilecache (as we had before), thread2 will get
	 * the cache lock and start evaling the second block of the shrink. 
	 * When it reaches the png reader it will stall until the first block 
	 * has been used ... but it never will, since thread1 will block on 
	 * this cache lock. 
	 */

	vips_get_tile_size( in, 
		&tile_width, &tile_height, &nlines );
	if( vips_tilecache( in, &t[4], 
		"tile_width", in->Xsize,
		"tile_height", 10,
		"max_tiles", 1 + (nlines * 2) / 10,
		"access", VIPS_ACCESS_SEQUENTIAL,
		"threaded", TRUE, 
		NULL ) )
		return( NULL );
	in = t[4];

	/* If the final affine will be doing a large downsample, we can get 
	 * nasty aliasing on hard edges. Blur before affine to smooth this out.
	 *
	 * Don't blur for very small shrinks, blur with radius 1 for x1.5
	 * shrinks, blur radius 2 for x2.5 shrinks and above, etc.
	 */
	sigma = ((1.0 / residual) - 0.5) / 1.5;
	if( residual < 1.0 &&
		sigma > 0.1 ) { 
		if( vips_gaussblur( in, &t[5], sigma, NULL ) )
			return( NULL );
		vips_info( "vipsthumbnail", "anti-alias, sigma %g",
			sigma );
		in = t[5];
	}

	if( vips_affine( in, &t[6], residual, 0, 0, residual, 
		"interpolate", interp,
		NULL ) )  
		return( NULL );
	in = t[6];

	vips_info( "vipsthumbnail", "residual scale by %g", residual );
	vips_info( "vipsthumbnail", "%s interpolation", 
		VIPS_OBJECT_GET_CLASS( interp )->nickname );

	/* Colour management.
	 *
	 * If we've already imported, just export. Otherwise, we're in 
	 * device space device and we need a combined
	 * import/export to transform to the target space.
	 */
	if( have_imported ) { 
		if( export_profile ||
			vips_image_get_typeof( in, VIPS_META_ICC_NAME ) ) {
			vips_info( "vipsthumbnail", 
				"exporting to device space with a profile" );
			if( vips_icc_export( in, &t[7], 
				"output_profile", export_profile,
				NULL ) )  
				return( NULL );
			in = t[7];
		}
		else {
			vips_info( "vipsthumbnail", "converting to sRGB" );
			if( vips_colourspace( in, &t[7], 
				VIPS_INTERPRETATION_sRGB, NULL ) ) 
				return( NULL ); 
			in = t[7];
		}
	}
	else if( export_profile &&
		(vips_image_get_typeof( in, VIPS_META_ICC_NAME ) || 
		 import_profile) ) {
		VipsImage *out;

		vips_info( "vipsthumbnail", 
			"exporting with profile %s", export_profile );

		/* We first try with the embedded profile, if any, then if
		 * that fails try again with the supplied fallback profile.
		 */
		out = NULL; 
		if( vips_image_get_typeof( in, VIPS_META_ICC_NAME ) ) {
			vips_info( "vipsthumbnail", 
				"importing with embedded profile" );

			if( vips_icc_transform( in, &t[7], export_profile,
				"embedded", TRUE,
				NULL ) ) {
				vips_warn( "vipsthumbnail", 
					_( "unable to import with "
						"embedded profile: %s" ),
					vips_error_buffer() );

				vips_error_clear();
			}
			else
				out = t[7];
		}

		if( !out &&
			import_profile ) { 
			vips_info( "vipsthumbnail", 
				"importing with fallback profile" );

			if( vips_icc_transform( in, &t[7], export_profile,
				"input_profile", import_profile,
				"embedded", FALSE,
				NULL ) )  
				return( NULL );

			out = t[7];
		}

		/* If the embedded profile failed and there's no fallback or
		 * the fallback failed, out will still be NULL.
		 */
		if( out )
			in = out;
	}

	/* If we are upsampling, don't sharpen, since nearest looks dumb
	 * sharpened.
	 */
	if( shrink >= 1 && 
		residual <= 1.0 && 
		sharpen ) { 
		vips_info( "vipsthumbnail", "sharpening thumbnail" );
		if( vips_conv( in, &t[8], sharpen, NULL ) ) 
			return( NULL );
		in = t[8];
	}

	if( delete_profile &&
		vips_image_get_typeof( in, VIPS_META_ICC_NAME ) ) {
		vips_info( "vipsthumbnail", 
			"deleting profile from output image" );
		if( !vips_image_remove( in, VIPS_META_ICC_NAME ) ) 
			return( NULL );
	}

	return( in );
}

/* Crop down to the final size, if crop_image is set. 
 */
static VipsImage *
thumbnail_crop( VipsObject *process, VipsImage *im )
{
	VipsImage **t = (VipsImage **) vips_object_local_array( process, 2 );

	if( crop_image ) {
		int left = (im->Xsize - thumbnail_width) / 2;
		int top = (im->Ysize - thumbnail_height) / 2;

		if( vips_extract_area( im, &t[0], left, top, 
			thumbnail_width, thumbnail_height, NULL ) )
			return( NULL ); 
		im = t[0];
	}

	return( im );
}

/* Auto-rotate, if rotate_image is set. 
 */
static VipsImage *
thumbnail_rotate( VipsObject *process, VipsImage *im )
{
	VipsImage **t = (VipsImage **) vips_object_local_array( process, 2 );
	VipsAngle angle = vips_autorot_get_angle( im );

	if( rotate_image &&
		angle != VIPS_ANGLE_D0 ) {
		/* Need to copy to memory, we have to stay seq.
		 */
		t[0] = vips_image_new_memory();
		if( vips_image_write( im, t[0] ) ||
			vips_rot( t[0], &t[1], angle, NULL ) )
			return( NULL ); 
		im = t[1];

		(void) vips_image_remove( im, ORIENTATION );
	}

	return( im );
}

/* Given (eg.) "/poop/somefile.png", write @im to the thumbnail name,
 * (eg.) "/poop/tn_somefile.jpg".
 */
static int
thumbnail_write( VipsObject *process, VipsImage *im, const char *filename )
{
	char *file;
	char *p;
	char buf[FILENAME_MAX];
	char *output_name;

	file = g_path_get_basename( filename );

	/* Remove the suffix from the file portion.
	 */
	if( (p = strrchr( file, '.' )) ) 
		*p = '\0';

	/* Don't use vips_snprintf(), we only want to optionally substitute a 
	 * single %s.
	 */
	vips_strncpy( buf, output_format, FILENAME_MAX ); 
	vips__substitute( buf, FILENAME_MAX, file ); 

	/* output_format can be an absolute path, in which case we discard the
	 * path from the incoming file.
	 */
	if( g_path_is_absolute( output_format ) ) 
		output_name = g_strdup( buf );
	else {
		char *dir;

		dir = g_path_get_dirname( filename );
		output_name = g_build_filename( dir, buf, NULL );
		g_free( dir );
	}

	vips_info( "vipsthumbnail", 
		"thumbnailing %s as %s", filename, output_name );

	g_free( file );

	if( vips_image_write_to_file( im, output_name, NULL ) ) {
		g_free( output_name );
		return( -1 );
	}
	g_free( output_name );

	return( 0 );
}

static int
thumbnail_process( VipsObject *process, const char *filename )
{
	VipsImage *sharpen = thumbnail_sharpen( process );

	VipsImage *in;
	VipsInterpolate *interp;
	VipsImage *thumbnail;
	VipsImage *crop;
	VipsImage *rotate;

	if( !(in = thumbnail_open( process, filename )) ||
		!(interp = thumbnail_interpolator( process, in )) ||
		!(thumbnail = 
			thumbnail_shrink( process, in, interp, sharpen )) ||
		!(crop = thumbnail_crop( process, thumbnail )) ||
		!(rotate = thumbnail_rotate( process, crop )) ||
		thumbnail_write( process, rotate, filename ) )
		return( -1 );

	return( 0 );
}

int
main( int argc, char **argv )
{
	GOptionContext *context;
	GOptionGroup *main_group;
	GError *error = NULL;
	int i;
	int result;

	if( VIPS_INIT( argv[0] ) )
	        vips_error_exit( "unable to start VIPS" );
	textdomain( GETTEXT_PACKAGE );
	setlocale( LC_ALL, "" );

	/* Does this vips have bicubic? Default to that if it
	 * does.
	 */
	if( vips_type_find( "VipsInterpolate", "bicubic" ) ) 
		interpolator = "bicubic";

        context = g_option_context_new( _( "- thumbnail generator" ) );

	main_group = g_option_group_new( NULL, NULL, NULL, NULL, NULL );
	g_option_group_add_entries( main_group, options );
	vips_add_option_entries( main_group ); 
	g_option_group_set_translation_domain( main_group, GETTEXT_PACKAGE );
	g_option_context_set_main_group( context, main_group );

	if( !g_option_context_parse( context, &argc, &argv, &error ) ) {
		if( error ) {
			fprintf( stderr, "%s\n", error->message );
			g_error_free( error );
		}

		vips_error_exit( "try \"%s --help\"", g_get_prgname() );
	}

	g_option_context_free( context );

	if( sscanf( thumbnail_size, "%d x %d", 
		&thumbnail_width, &thumbnail_height ) != 2 ) {
		if( sscanf( thumbnail_size, "%d", &thumbnail_width ) != 1 ) 
			vips_error_exit( "unable to parse size \"%s\" -- "
				"use eg. 128 or 200x300", thumbnail_size );

		thumbnail_height = thumbnail_width;
	}

	result = 0;

	for( i = 1; i < argc; i++ ) {
		/* Hang resources for processing this thumbnail off @process.
		 */
		VipsObject *process = VIPS_OBJECT( vips_image_new() ); 

		if( thumbnail_process( process, argv[i] ) ) {
			fprintf( stderr, "%s: unable to thumbnail %s\n", 
				argv[0], argv[i] );
			fprintf( stderr, "%s", vips_error_buffer() );
			vips_error_clear();

			/* We had a conversion failure: return an error code
			 * when we finally exit.
			 */
			result = -1;
		}

		g_object_unref( process );
	}

	vips_shutdown();

	return( result );
}
