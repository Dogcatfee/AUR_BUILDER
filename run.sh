#!/bin/bash

source ./defines.sh

./git_build_packages.sh
./update.sh $repo_name $repo_dir
