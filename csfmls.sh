#!/usr/bin/env bash
clear

set -e

# BASH COLORS
green() { printf "\033[32m${1}\033[0m\n\n"; }
orange() { printf "\033[38;5;208m${1}\033[0m\n"; }
blue() { printf "\033[38;5;27m${1}\033[0m\n" ; }

VERSION=2.5.1

# SET VERSION TO AV[1]
if [[ -n "$1" ]]; then
    VERSION="$1"
fi

orange "Packages installation..."
sudo apt-get install -y make \
                        cmake \
                        perl \
                        gcc \
                        curl \
                        wget \
                        build-essential \
                        ocaml \
                        libncurses5 \
                        git \
                        libx11-dev \
                        libxmu-dev \
                        libxi-dev \
                        libgl-dev \
                        libopenal-dev \
                        libxrandr-dev \
                        libudev-dev \
                        libglew-dev \
                        libjpeg-dev \
                        libfreetype6-dev \
                        libsndfile-dev \
                        libalut-dev \
                        libsfml-dev
green "Packages installed"

cd /tmp

orange "Removing old installation files..."
sudo rm -rf SFML-$VERSION
sudo rm -rf CSFML
green "Done cleaning"

orange "Downloading SFML-$VERSION..."
if ! [[ -d SFML-"$VERSION" ]]; then
    if ! [[ -f SFML-"$VERSION"-sources.zip ]]; then
        wget https://www.sfml-dev.org/files/SFML-"$VERSION"-sources.zip
    fi
    yes A | unzip SFML-"$VERSION"-sources.zip
fi
green "Done downloading SFML-$VERSION"

orange "Building SFML-$VERSION..."
cd SFML-"$VERSION"
cmake .
cmake --build .
sudo make install
green "Done building SFML-$VERSION"

orange "Deleting ZIP file..."
cd ..
rm -f SFML_FILE-"$VERSION"-sources.zip
green "Done"

orange "Cloning CSFML..."
git clone https://github.com/SFML/CSFML.git
green "Done cloning"

orange "Building CSFML-..."
cd CSFML
cmake -DCMAKE_MODULE_PATH="/tmp/SFML-$VERSION/cmake/Modules" .
make
sudo make install
green "Done building CSFML"

orange "Cleaning..."
cd ..
sudo rm -rf CSFML
sudo rm -rf SFML-$VERSION
green "Done cleaning"

orange "Linking libs"
sudo ldconfig -v
green "Done linking"

blue "SFML-$VERSION and CSFML have been compiled"
blue "Provided by Thibault B. - 2020 - Epitech Lille Promo 2025"