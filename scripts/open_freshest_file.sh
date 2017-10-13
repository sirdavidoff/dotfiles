#!/bin/bash
if [[ $# -eq 0 ]]; then
  echo "Please supply the file/directory to look at as an argument"
  exit
fi

if [[ -d $1 ]]; then

  # We have a directory - find the last modified file and open it
  FILE=$(ls -rt1 "$1" | tail -1)
  echo "Opening $1/$FILE"
  open "$1/$FILE"

else

  # We have a file - look in the file's directory for the last modified 
  # file with a similar name and open it
  # Strip the front date, file extension and version number from the file name

  #echo $(basename "$1")

  # Take off any numbers at the beginning of the file name (e.g. "20171013")
  DIR=$(basename "$1")
  CORE=$(echo "$DIR" | sed -e "s/^[0-9]*[[:space:]]*\(.*\)/\1/")
  echo "No date: $CORE"

  # Take off the file extension
  EXT="${CORE##*.}"
  echo "Ext is: $EXT"
  CORE=$(echo "$CORE" | sed -e "s/\.[^.]*$//")
  echo "No suffix: $CORE"

  # Take off any version number at the end (e.g. "v02")
  # We use perl for its lazy evaluation (.*?) abilities
  CORE=$(echo "$CORE" | perl -pe "s/(.*?)[ v]+[0-9]+/\1/")
  echo "No version: $CORE"

  DIR=$(dirname "$1")
  FILE=$(ls -rt1 "$DIR" | grep "$CORE" | grep "$EXT$" | tail -1)

  echo "File is $FILE"
  open "$DIR/$FILE"

fi

