#!/bin/bash

repo_name='custom'
repo_dir=./x86_64

if [ "$1" != "" ]; then
    echo "Init repo at $1"
    repo_dir=$1
else
    echo "Init repo at default location"
fi

cd $repo_dir

#repo-add ./custom.db.tar.gz ./*
repo-add -n -R $repo_name.db.tar.gz *.pkg.tar.xz
repo-add -n -R $$repo_name.db.tar.gz *.pkg.tar.zst

rm custom.db
cp -f $repo_name.db.tar.gz custom.db

rm *gz.old

echo "Repo Up"