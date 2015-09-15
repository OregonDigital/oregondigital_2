top_srcdir=/home/lsato/oregondigital_2/vips_install/vips-7.42.3
# we need a different tmp for each script since make can run tests in parallel
tmp=$top_srcdir/test/tmp-$$
test_images=$top_srcdir/test/images
image=$test_images/IMG_4618.jpg
mkdir -p $tmp
vips=$top_srcdir/tools/vips
vipsthumbnail=$top_srcdir/tools/vipsthumbnail
vipsheader=$top_srcdir/tools/vipsheader
