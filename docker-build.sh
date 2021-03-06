#!/bin/bash

# Builds all QT 5.9.5 packages in the imrehg/archlinux-makepkg Docker image

# Exit or error and echo commands as executued
set -e
set -x

# Ensure image is up-to-date
sudo pacman -Syu --noconfirm

export PACKAGER="Cian McGovern <cian@cianmcgovern.com>"

PACKAGES="qt5-base-595 qt5-xmlpatterns-595 qt5-declarative-595 qt5-location-595 qt5-quickcontrols-595 qt5-tools-595 qt5-webchannel-595 qt5-webengine-595 qt5-x11extras-595"

for package in $PACKAGES; do
    cd $package
    # Build package
    makepkg -si --noconfirm

    # Upload each built package to https://transfer.sh
    for package_file in $package-*.pkg.*; do
        sha256sum $package_file | tee -a $WORKSPACE/packages.txt
        mv $package_file $WORKSPACE
    done

    cd ..
done

cat $WORKSPACE/packages.txt