#!/bin/bash


repo_dir=./aur_repo_x86_64
if [ "$1" != "" ]; then
    echo "Init repo at $1"
    repo_dir=$1
else
    echo "Init repo at default location"
fi

cd $repo_dir
repo-add ./custom.db.tar.gz ./*
