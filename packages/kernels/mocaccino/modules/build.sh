#!/bin/bash

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
