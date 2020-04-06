#!/bin/bash

aget () {
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

./clean.sh


while read repo; do
  aget $repo
done < packages.x86_64

#Move all packages to repo_dir
mkdir $repo_dir
for package in $(find -name "*.pkg.tar.xz"); do
  mv "$package" $repo_dir
done
