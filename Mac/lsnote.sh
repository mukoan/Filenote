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
  if [[ "${ELEMENTS[0]}" == "total" ]]; then
    continue
  fi

  CANDIDATE_FILE="${ELEMENTS[${#ELEMENTS[@]}-1]}"
  CANDIDATE_FILE=$(echo ${CANDIDATE_FILE} | sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g")

  # List attributes set for the file
  IFS=$'\n'
  HAS_NOTE=0
  ATTRIBUTES=$(xattr "$CANDIDATE_FILE")
  for line in $ATTRIBUTES; do
    if [[ $line == "filenote" ]]; then
      HAS_NOTE=1
    fi
  done

  # Extract and output note
  if [ $HAS_NOTE -eq 1 ]; then
    NOTE=$(xattr -p filenote ${CANDIDATE_FILE})
    if [[ ! -z "$NOTE" ]]
    then
      echo $NOTE
    fi
  fi
done

exit 0
