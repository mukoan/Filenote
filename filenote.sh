# !/bin/bash
# File  : filenote.sh
# Date  : 2020.06.10
# Author: Lyndon Hill
# Brief : Creates a note for a file in the file system;
#         e.g. original file = "README.txt", comment is ".README.txt.fn"
#         Starts with dot to hide, ends with fn extension.

# Usage:
# filenote.sh <filename> <comment>
#   Adds or overwrites existing note file; does not ask to overwrite
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
    echo "Basename on $1"
    FILENAME=$(basename $1)
    ROUTE=$(dirname $1)

    cat "$ROUTE/.$FILENAME.fn"      # if filenote exists
  fi
  ;;
2)
  ## if arg 1 == -d then delete note for file arg2 if it exists

  if [ $1 = "-d" ]; then
    FILENAME=$(basename $2)
    ROUTE=$(dirname $2)
    NOTEFILE="$ROUTE/.$FILENAME.fn"

    if [ -e $NOTEFILE ]; then
      rm $NOTEFILE
    fi
    exit 0
  fi

  ## else replace/create note for file arg1 with text in arg2, if arg1 exists

  FILENAME=$(basename $1)
  ROUTE=$(dirname $1)
  NOTEFILE="$ROUTE/.$FILENAME.fn"
  echo "$2" > $NOTEFILE
  ;;
esac

exit 0
