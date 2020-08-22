#!/bin/bash
# File  : lsnote.sh
# Date  : 2020.06.10
# Author: Lyndon Hill
# Brief : List files and directories and show notes

LISTING=$(ls --color -l)

IFS=$'\n'
FILES=$LISTING

for f in ${FILES[@]};
do
  IFS=$'%'
  echo $f
  IFS=$' '
  read -ra ELEMENTS <<< "$f"
  NOTENAME=".${ELEMENTS[${#ELEMENTS[@]}-1]}.fn"
  DECOLOURISED=$(echo ${NOTENAME} | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
  if [ -f $DECOLOURISED ]; then
    cat $DECOLOURISED
  fi
done
