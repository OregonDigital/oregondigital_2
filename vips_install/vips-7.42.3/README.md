# libvips : an image processing library

[![Build Status](https://secure.travis-ci.org/jcupitt/libvips.png)](http://travis-ci.org/jcupitt/libvips)

libvips is a 2D image processing library. Compared to
similar libraries, [libvips runs quickly and uses little
memory](http://www.vips.ecs.soton.ac.uk/index.php?title=Speed_and_Memory_Use).
livips is licensed under the LGPL 2.1+.

It has around 300 operations covering arithmetic, histograms, convolutions,
morphological operations, frequency filtering, colour, resampling, statistics
and others. It supports a large range of numeric formats, from 8-bit int to
128-bit complex. It supports a good range of image formats, including
JPEG, TIFF, PNG, WebP, FITS, Matlab, OpenEXR, DeepZoom, and OpenSlide. 
It can also load images via ImageMagick or GraphicsMagick.

It has APIs for C and C++ and comes with a Python
binding and a command-line interface. Bindings are
available for Ruby, JavaScript and others. There is full
[documentation](http://www.vips.ecs.soton.ac.uk/supported/current/doc/html/libvips/index.html).

There's a GUI as well, see the [VIPS website](http://www.vips.ecs.soton.ac.uk).

There are packages for most unix-like operating systems and binaries for
Windows and OS X.

# Building libvips from source

In the libvips directory you should just be able to do:

	$ ./configure
	$ make
	$ sudo make install

By default this will install files to `/usr/local`.

See the Dependencies section below for a list of the things that
libvips needs in order to be able to build.

We have detailed guides on the wiki for [building on
Windows](http://www.vips.ecs.soton.ac.uk/index.php?title=Build_on_windows)
and [building on OS
X](http://www.vips.ecs.soton.ac.uk/index.php?title=Build_on_OS_X).

# Building libvips from git

Checkout the latest sources with:

	$ git clone git://github.com/jcupitt/libvips.git

Building from git needs more packages. You'll need at least swig and gtk-doc,
see the dependencies section below. For example:

	$ brew install gtk-doc swig

Then build the build system with:

	$ ./bootstrap.sh

Debug build:

	$ CFLAGS="-g -Wall" CXXFLAGS="-g -Wall" \
		./configure --prefix=/home/john/vips 
	$ make
	$ make install

Leak check:

	$ export G_DEBUG=gc-friendly
	$ export G_SLICE=always-malloc
	$ valgrind --suppressions=libvips.supp \
		--leak-check=yes \
		vips ... > vips-vg.log 2>&1

valgrind threading check:

	$ valgrind --tool=helgrind vips ... > vips-vg.log 2>&1

Clang build:

	$ CC=clang CXX=clang++ ./configure --prefix=/home/john/vips

Clang static analysis:

	$ scan-build ./configure --disable-introspection
	$ scan-build -o scan -v make 
	$ scan-view scan/2013-11-22-2

Clang dynamic analysis:

	$ FLAGS="-O1 -g -fsanitize=address"
	$ FLAGS="$FLAGS -fno-omit-frame-pointer -fno-optimize-sibling-calls"
	$ CC=clang CXX=clang++ LD=clang \
		CFLAGS="$FLAGS" CXXFLAGS="$FLAGS" LDFLAGS=-fsanitize=address \
		./configure --prefix=/home/john/vips --disable-introspection

	$ FLAGS="-O1 -g -fsanitize=thread"
	$ FLAGS="$FLAGS -fPIC -pie"
	$ FLAGS="$FLAGS -fno-omit-frame-pointer -fno-optimize-sibling-calls"
	$ CC=clang CXX=clang++ LD=clang \
		CFLAGS="$FLAGS" CXXFLAGS="$FLAGS" \
		LDFLAGS="-fsanitize=thread -fPIC -pie" \
		./configure --prefix=/home/john/vips --disable-introspection

Build with the GCC auto-vectorizer and diagnostics (or just -O3):

	$ FLAGS="-O2 -msse4.2 -ffast-math"
	$ FLAGS="$FLAGS -ftree-vectorize -fdump-tree-vect-details"
	$ CFLAGS="$FLAGS" CXXFLAGS="$FLAGS" \
		./configure --prefix=/home/john/vips --disable-introspection \
		--enable-debug=no

Static analysis with:

	$ cppcheck --force --enable=style . &> cppcheck.log

# Dependencies 

libvips has to have gettext, glib-2.x and libxml-2.0. The build system
needs sh, pkg-config, swig, gtk-doc-tools, automake, gobject-introspection
and gnu make.

# Optional dependencies

If suitable versions are found, libvips will add support for the following
libraries automatically. See `./configure --help` for a set of flags to
control library detection. Packages are generally found with `pkg-config`,
so make sure that is working.

libtiff and libjpeg do not usually use pkg-config so libvips looks for
them in the default path and in $prefix. If you have installed your own
versions of these libraries in a different location, libvips will not see
them. Use switches to libvips configure like:

	./configure --prefix=/Users/john/vips \
		--with-tiff-includes=/opt/local/include \
		--with-tiff-libraries=/opt/local/lib \
		--with-jpeg-includes=/opt/local/include \
		--with-jpeg-libraries=/opt/local/lib

or perhaps:

	CFLAGS="-g -Wall -I/opt/local/include -L/opt/local/lib" \
		CXXFLAGS="-g -Wall -I/opt/local/include -L/opt/local/lib" \
		./configure --without-python --prefix=/Users/john/vips 

to get libvips to see your builds.

## libjpeg

The IJG JPEG library. 

## libexif

If available, libvips adds support for EXIF metadata in JPEG files.

## libgsf-1

If available, libvips adds support for creating image pyramids with dzsave. 

## libtiff

The TIFF library. It needs to be built with support for JPEG and
ZIP compression. 3.4b037 and later are known to be OK. 

## fftw3

If libvips finds this library, it uses it for fourier transforms. It
can also use fftw2, but 3 is faster and more accurate.

## lcms2, lcms

If present, im_icc_import(), _export() and _transform() are available
for transforming images with ICC profiles. If lcms2 is available,
it is used in preference to lcms since it is faster.

## Large files

libvips uses the standard autoconf tests to work out how to support
large files (>2GB) on your system. Any reasonably recent *nix should
be OK.

## libpng

If present, libvips can load and save png files. 

## libMagick, or optionally GraphicsMagick

if available, libvips adds support for loading all libMagick supported
image file types (about 80 different formats). Use
`--with-magickpackage` to build against graphicsmagick instead.

## pangoft2

If available, libvips adds support for text rendering. You need the
package pangoft2 in `pkg-config --list-all`.

## orc-0.4

If available, vips will accelerate some operations with this run-time
compiler.

## matio

If available, vips can load images from Matlab save files.

## cfitsio

If available, vips can load FITS images.

## libwebp

If available, vips can load and save WebP images.

## OpenEXR

If available, libvips will directly read (but not write, sadly)
OpenEXR images.

## OpenSlide

If available, libvips can load OpenSlide-supported virtual slide
files: Aperio, Hamamatsu, Leica, MIRAX, Sakura, Trestle, and Ventana.

## swig, python, python-dev

If available, we build the python binding too.

# Disclaimer

No guarantees of performance accompany this software, nor is any
responsibility assumed on the part of the authors. Please read the licence
agreement.

