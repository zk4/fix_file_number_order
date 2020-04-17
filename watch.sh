#!/bin/bash

fullfile=$1
filename=$(basename -- "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
DIR=$(dirname "$(realpath fullfile)")
cd $DIR
watchexec -ce  $extension   'clear && time go run $fullfile'
