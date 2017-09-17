#!/bin/bash


repo_dir=./aur_repo_x86_64
if [ "$1" != "" ]; then
    echo "Placing AUR repo at $1"
    repo_dir=$1
else
    echo "Using default directory"
fi

#Remove all directories
yes | rm -r $(echo */)

#Clone repos listed in git.links file
while read repo; do
  git clone "$repo"
done < git.links

#Build all packages
for package in $(echo */); do
  cd "$package"
  makepkg -s
  cd ..
done

#Move all packages to repo_dir
mkdir $repo_dir
for package in $(find -name "*.pkg.tar.xz"); do
  mv "$package" $repo_dir
done
