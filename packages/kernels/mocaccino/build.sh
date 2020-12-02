#!/bin/bash

MAJOR_VERSION=$(awk -F. '{print $1"."$2}' <<< $PACKAGE_VERSION)
mkdir output
pushd linux 

make -j$(nproc --ignore=1)

if [[ -L "arch/${ARCH}/boot/bzImage" ]]; then
   mv $(readlink -f "arch/${ARCH}/boot/bzImage") ../output/"${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino"
else
   mv arch/${ARCH}/boot/bzImage ../output/"${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino"
fi
