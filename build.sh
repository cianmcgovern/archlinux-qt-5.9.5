#!/bin/bash

set -e
set -x

sudo pacman -Syu --noconfirm

export PACKAGER="Cian McGovern (Travis CI) <cian@cianmcgovern.com>"

PACKAGES="qt5-base-595 qt5-xmlpatterns-595 qt5-declarative-595 qt5-location-595 qt5-quickcontrols-595 qt5-tools-595 qt5-webchannel-595 qt5-webengine-595 qt5-x11extras-595"

for package in $PACKAGES; do
    cd $package
    makepkg -cCf -si --noconfirm
    sha256sum $package-*.tar.xz
    cd ..
done