#!/bin/bash


repo_dir=./x86_64

#Remove all directories
yes | rm -r $(echo */)

python3 links_gen.py > pkg_links

#Clone repos listed in git.links file
while read repo; do
  git clone "$repo"
done < pkg_links

rm pkg_links

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
