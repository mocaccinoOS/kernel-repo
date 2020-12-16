#!/bin/bash

PACKAGE_VERSION=${PACKAGE_VERSION%\+*}
MAJOR_VERSION=$(awk -F. '{print $1"."$2}' <<< $PACKAGE_VERSION)
outdir="/luetbuild/modules"
mkdir -p $outdir/boot
pushd linux 

if [ ! -e "arch/x86/boot/bzImage" ]; then
    cp -rfv ../output/* arch/x86/boot/bzImage || true
fi

make -j$(nproc --ignore=1) modules_install install \
		INSTALL_MOD_PATH="$outdir" \
		INSTALL_PATH="$outdir"/boot

rm -f "$outdir"/lib/modules/**/build \
    "$outdir"/lib/modules/**/source

popd

mv $outdir/boot/config-$PACKAGE_VERSION $outdir/boot/config-${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino
mv $outdir/boot/System.map-$PACKAGE_VERSION $outdir/boot/System.map-${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino
mv $outdir/boot/vmlinuz-$PACKAGE_VERSION $outdir/boot/vmlinuz-${KERNEL_PREFIX}-${ARCH}-${MAJOR_VERSION}.0-mocaccino
