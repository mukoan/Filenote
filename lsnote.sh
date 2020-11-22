#!/bin/bash
# File  : lsnote.sh
# Date  : 2020.06.10
# Author: Lyndon Hill
# Brief : List files and directories and show notes

TARGET="."
if [ $# -gt 0 ]; then
  if [ -d "$1" ]; then
    TARGET="$1"
  fi
fi

if [[ $(uname) == "Darwin" ]]; then
  LISTING=$(CLICOLOR_FORCE=1 ls -Gl $TARGET)
else
  LISTING=$(ls --color -l $TARGET)
fi

IFS=$'\n'
FILES=$LISTING

SKIPFIRSTLINE=1
for f in ${FILES[@]};
do
  IFS=$'%'
  echo $f
  IFS=$' '
  if [ $SKIPFIRSTLINE -eq 1 ]; then SKIPFIRSTLINE=0; continue; fi
  read -ra ELEMENTS <<< "$f"
  NOTENAME=".${ELEMENTS[${#ELEMENTS[@]}-1]}.fn"
  DECOLOURISED=$(echo ${NOTENAME} | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g")

  DECOLOURISED=${TARGET}/$DECOLOURISED

  if [ -f $DECOLOURISED ]; then
    cat $DECOLOURISED
  fi
done
