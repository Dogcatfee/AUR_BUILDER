#!/bin/bash

source defines.sh

dirs=$(echo */)


for dir in $dirs
do
    if [[ $dir != $repo_dir/ ]]; then
        echo $dir
        yes | rm -r $dir
    fi
done



