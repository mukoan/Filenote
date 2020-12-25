#!/bin/bash
# File  : lsnote.sh
# Date  : 2020.06.10
# Author: Lyndon Hill
# Brief : List files and directories and show notes

# Function: Decolourise a string
decolourise () {
  NOCOLOUR=$(echo $1 | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g")
  echo "$NOCOLOUR"
}

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
  # Detect if file is a link
  case ${f:0:1} in
    "l") FILEISLINK=1 ;;
      *) FILEISLINK=0 ;;
  esac

  # Get the filename
  IFS=$'%'
  echo $f
  IFS=$' '
  if [ $SKIPFIRSTLINE -eq 1 ]; then SKIPFIRSTLINE=0; continue; fi
  read -ra ELEMENTS <<< "$f"

  case $FILEISLINK in
    0) NOTENAME=".${ELEMENTS[${#ELEMENTS[@]}-1]}.fn" ;;
    1) NOTENAME=".${ELEMENTS[${#ELEMENTS[@]}-3]}.fn" ;;
  esac
  
  # Remove colour escape codes
  DECOLOURISED=$( decolourise $NOTENAME )

  if [ -f ${TARGET}/${DECOLOURISED} ]; then
    cat $DECOLOURISED
  fi
done
