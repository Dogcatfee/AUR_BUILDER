#!/bin/bash

cd $2

repo-add -n -R $1.db.tar.gz *.tar.xz
repo-add -n -R $1.db.tar.gz *.pkg.tar.zst

rm $1.db
cp -f $1.db.tar.gz $1.db

rm *gz.old

echo "Repo Up"

cd ../
