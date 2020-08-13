#!/bin/bash

CMD=''
if [[ $@ == git* ]];
then
  CMD=.git 
else
  CMD=Podfile
fi

#echo $CMD
find . -name $CMD | while read f; do 
  #echo "cmd:"  $@
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  printf "${RED} `dirname $f` -> $@  ${NC}\n"
  pushd `dirname $f` && eval $@  
  popd
done
