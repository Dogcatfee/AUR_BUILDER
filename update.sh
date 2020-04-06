#!/bin/bash

repo_dir=./x86_64

if [ "$2" != "" ]; then
    echo "Init repo at $2"
    repo_dir=$2
else
    echo "Init repo at default location"
fi

cd $repo_dir

#repo-add ./custom.db.tar.gz ./*
repo-add -R $1.db.tar.gz *.pkg.tar.xz
repo-add -R $1.db.tar.gz *.pkg.tar.zst

rm custom.db
cp -f $1.db.tar.gz custom.db

rm *gz.old

echo "Repo Up"