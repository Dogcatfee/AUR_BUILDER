#!/bin/bash

AUR_URL="https://aur.archlinux.org/"
REPO_DIR=./aur_repo_x86_64

if [ "$1" != "" ]; then
    echo "Placing AUR repo at $1"
    REPO_DIR=$1
else
    echo "Using default directory"
fi

# Initialization
mkdir -p ./pkgbuilds
mkdir -p $REPO_DIR

# Parse git.links and clone packages
while read repo; do
    if [ "$repo" == "" ]; then
        continue
    fi
    tokens=( $repo )
    CLONE_URL=""
    PKG_PATH=""
    if [ ${tokens[0]} == "#" ]; then
        continue
    elif [ ${tokens[0]} == "aur" ]; then
        CLONE_URL="$AUR_URL${tokens[1]}.git"
        PKG_PATH="./pkgbuilds/${tokens[1]}"
    elif [ ${tokens[0]} == "url" ]; then
        CLONE_URL="${tokens[1]}"
        PKG_PATH="./pkgbuilds/$(basename ${tokens[1]})"
    else
        echo "unhandled url type"
        continue
    fi
    # clone each package
    git clone $CLONE_URL $PKG_PATH
done < git.links

#Build all packages
for package in ./pkgbuilds/*; do
    (cd "$package"; makepkg -s)
done

# Move all packages to REPO_DIR
mkdir -p $REPO_DIR
for package in $(find -name "*.pkg.tar.xz"); do
  mv "$package" $REPO_DIR
done

# Initialize repo with all packages
cd $REPO_DIR
repo-add ./custom.db.tar.gz ./*
