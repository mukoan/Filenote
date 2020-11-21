#!/bin/bash
# File  : filenote.sh
# Date  : 2020.11.11
# Author: Lyndon Hill
# Brief : Creates a note for a file in the extended attributes

# Usage:
# filenote.sh <filename> <comment>
#   Adds or overwrites existing note; does not ask to overwrite
# filenote.sh <filename>
#   Read current note; does nothing if no note exists
# filenote.sh -d <filename>
#   Delete note; does nothing if no note exists

case $# in
0)
  echo "Usage: filenote.sh <filename> [comment]"
  ;;
1)
  if [ -e $1 ]; then
    xattr -p filenote "$1"      # if filenote exists
  fi
  ;;
2)
  ## if arg 1 == -d then delete note for file arg 2 if it exists
  if [ $1 = "-d" ]; then
    xattr -d filenote "$2"
    exit 0
  fi

  xattr -w filenote "$2" "$1"
  ;;
esac

exit 0
