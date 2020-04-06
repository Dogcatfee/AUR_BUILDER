#!/bin/bash

basedir=$( cd `dirname $0`; pwd )

aget () {
    yes | rm -r $1
    git clone https://aur.archlinux.org/"$1".git
    # curl -fO https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz
    cd $1
    makepkg -s
    cd ..
}


repo_dir=./x86_64


if [ "$1" != "" ]; then
    echo "Placing AUR repo at $1"
    repo_dir=$1
else
    echo "Using default directory"
fi

list=`grep -v '^#' ./packages.x86_64`

for pkg in $list; do
    if [[ ! -d $pkg ]]; then
        aget $pkg
    fi
done

mkdir $repo_dir
for package in $(find -name "*.pkg.tar.xz"); do
    mv "$package" $repo_dir
done
