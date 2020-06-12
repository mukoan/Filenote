#!/bin/bash
# File  : lsnote.sh
# Date  : 2020.06.10
# Author: Lyndon Hill
# Brief : List files and directories and show notes

LISTING=$(ls -l)

IFS=$'\n'
FILES=$LISTING

for f in ${FILES[@]};
do
  echo $f
  IFS=$' '
  read -ra ELEMENTS <<< "$f"
  NOTENAME=".${ELEMENTS[${#ELEMENTS[@]}-1]}.fn"
  if [ -f $NOTENAME ]; then
    cat $NOTENAME
  fi
done
