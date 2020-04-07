#!/bin/bash

repo-add -s -R $1.db.tar.gz *.tar.xz
repo-add -s -R $1.db.tar.gz *.pkg.tar.zst

rm $1.db
cp -f $1.db.tar.gz $1.db

rm *gz.old

echo "Repo Up"