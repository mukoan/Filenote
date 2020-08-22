#!/bin/bash
# File  : lsnote.sh
# Date  : 2020.06.10
# Author: Lyndon Hill
# Brief : List files and directories and show notes

if [[ $(uname) == "Darwin" ]]; then
  LISTING=$(CLICOLOR_FORCE=1 ls -Gl)
else
  LISTING=$(ls --color -l)
fi

IFS=$'\n'
FILES=$LISTING

for f in ${FILES[@]};
do
  IFS=$'%'
  echo $f
  IFS=$' '
  read -ra ELEMENTS <<< "$f"
  NOTENAME=".${ELEMENTS[${#ELEMENTS[@]}-1]}.fn"
  DECOLOURISED=$(echo ${NOTENAME} | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g")
  if [ -f $DECOLOURISED ]; then
    cat $DECOLOURISED
  fi
done
