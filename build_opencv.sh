#!/bin/sh

rm -r opencv opencv2.xcframework

git clone https://github.com/opencv/opencv.git
cd opencv

python3 platforms/apple/build_xcframework.py -o output \
--iphoneos_archs arm64 --iphonesimulator_archs x86_64,arm64 \
--iphoneos_deployment_target 13.4 \
--without apps \
--without shape \
--without videostab \
--without superres \
--without videoio \
--without video \
--without calib3d \
--without features2d \
--without objdetect \
--without dnn \
--without ml \
--without flann \
--without photo \
--without highgui \
--without stitching \
--without world \
--without gapi \
--without java \
--without python2 \
--without python3 \
--without objc \
--without java_bindings_generator \
--without js_bindings_generator \
--without objc_bindings_generator \
--disable 1394 \
--disable ADE \
--disable AVFOUNDATION \
--disable CAP_IOS \
--disable IMGCODEC_HDR \
--disable IMGCODEC_PFM \
--disable IMGCODEC_PXM \
--disable IMGCODEC_SUNRASTER \
--disable PROTOBUF \
--disable QUIRC \
--disable WEBP \
--disable-swift

cp -rp output/opencv2.xcframework ../opencv2.xcframework
cd ..

exit 0
