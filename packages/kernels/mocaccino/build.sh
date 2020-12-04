#!/bin/bash
PACKAGE_VERSION=${PACKAGE_VERSION%\+*}
MAJOR_VERSION=$(awk -F. '{print $1"."$2}' <<< $PACKAGE_VERSION)
mkdir -p output/boot
pushd linux 

make -j$(nproc --ignore=1) KBUILD_BUILD_VERSION="$PACKAGE_VERSION-Mocaccino"

if [[ -L "arch/${ARCH}/boot/bzImage" ]]; then
   cp -rfv $(readlink -f "arch/${ARCH}/boot/bzImage") ../output/boot/"${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino"
else
   cp -rfv arch/${ARCH}/boot/bzImage ../output/boot/"${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino"
fi
