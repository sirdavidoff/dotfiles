#!/bin/bash

# Usage:
# 1) Open the most recently-modified file in a directory
# ./open_freshest_file.sh "path_to_dir"
# 2) Open the most recent version of a file in the same directory
# ./open_freshest_file.sh "path_to_file"
#
# NB: If you add an extra argument '-echo' on the end, the script just
# outputs the path of the file to be opened and doesn't open it

if [[ $# -eq 0 ]]; then
  echo "Please supply the file/directory to look at as an argument"
  exit
fi

if [[ -d $1 ]]; then

  # We have a directory - find the last modified file and open it
  FILE=$(ls -rt1 "$1" | tail -1)
  OUT="$1/$FILE"

else

  # We have a file - look in the file's directory for the last modified 
  # file with a similar name and open it
  # Strip the front date, file extension and version number from the file name

  #echo $(basename "$1")

  # Take off any numbers at the beginning of the file name (e.g. "20171013")
  DIR=$(basename "$1")
  CORE=$(echo "$DIR" | sed -e "s/^[0-9]*[[:space:]]*\(.*\)/\1/")
  #echo "No date: $CORE"

  # Take off the file extension
  EXT="${CORE##*.}"
  #echo "Ext is: $EXT"
  CORE=$(echo "$CORE" | sed -e "s/\.[^.]*$//")
  #echo "No suffix: $CORE"

  # Take off any version number at the end (e.g. "v02")
  # We use perl for its lazy evaluation (.*?) abilities
  CORE=$(echo "$CORE" | perl -pe "s/(.*?)[ v]+[0-9]+/\1/")
  #echo "No version: $CORE"

  DIR=$(dirname "$1")
  FILE=$(ls -rt1 "$DIR" | grep "$CORE" | grep "$EXT$" | tail -1)

  OUT="$DIR/$FILE"

fi


if [[ -n $2 && $2 -eq "-echo" ]]; then
  # TODO: This is triggered for any non-empty $2
  echo $OUT
else
  open $OUT
fi
