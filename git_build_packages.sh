#!/bin/bash

source defines.sh

basedir=$( cd `dirname $0`; pwd )

aget () {
    yes | rm -r $1
    git clone https://aur.archlinux.org/"$1".git
    # curl -fO https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz
    cd $1
    makepkg -s
    cd ..
}


list=`grep -v '^#' ./packages.x86_64`
echo $list

for pkg in $list; do
    if [[ ! -d $pkg ]]; then
        aget $pkg
    fi
done

for package in $(find -name "*.pkg.tar.xz"); do
    cp "$package" $repo_dir
done