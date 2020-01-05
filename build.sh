#!/bin/bash

set -e
set -x

echo 'MAKEFLAGS="-j$(nproc)"' >> /etc/makepkg.conf

useradd --no-create-home --shell=/bin/false build && usermod -L build
echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

pacman --noconfirm -Syu
pacman --noconfirm -S base-devel

mkdir /packages && chown build /packages
export PKGDEST=/packages
export BUILDDIR=/tmp
export SRCDEST=/tmp
export PACKAGER="Cian McGovern (Travis CI) <cian@cianmcgovern.com>"

PACKAGES="qt5-base-595 qt5-xmlpatterns-595 qt5-declarative-595 qt5-location-595 qt5-quickcontrols-595 qt5-tools-595 qt5-webchannel-595 qt5-webengine-595 qt5-x11extras-595"

for package in $PACKAGES; do
    cd $package
    ls -la
    sudo -E -u build pwd
    sudo -E -u build ls -la
    sudo -E -u build makepkg -cCf -si --noconfirm
    cd ..
done