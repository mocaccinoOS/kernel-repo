#!/bin/bash
set -ex
PACKAGE_VERSION=${PACKAGE_VERSION%\+*}
wget https://cdn.kernel.org/pub/linux/kernel/v${PACKAGE_VERSION:0:1}.x/linux-${PACKAGE_VERSION}.tar.xz -O kernel.tar.xz
tar xvJf kernel.tar.xz
mv linux-${PACKAGE_VERSION} linux
cp -rfv mocaccino-$ARCH.config linux/.config
cd linux
make olddefconfig
touch /etc/passwd
chmod 644 /etc/passwd
echo "root:x:0:0:root:/root:/bin/sh" > /etc/passwd
