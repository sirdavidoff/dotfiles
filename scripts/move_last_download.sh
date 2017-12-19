#!/usr/bin/env bash

FROM_DIR="$HOME/Downloads"

# Displays a prompt with two buttons
function prompt() {
  osascript <<EOT
    tell app "System Events"
      button returned of (display dialog "$1" buttons {"Cancel", "$2"} default button 2 with title "$(basename $0)")
    end tell
EOT
}

if [[ $# -eq 0 ]]; then
  echo "Please supply the directory to move to as an argument"
  exit
fi

if [[ -f $1 ]]; then
  # We have a file - get the directory it's in
  DEST=$(dirname "$1")
elif [[ -d $1 ]]; then
  # We have a directory
  DEST=$1
else
  # We have something weird
  echo "Argument is not a valid directory"
  exit
fi

LATEST_FILE=$(ls -rt1 "$FROM_DIR" | tail -1)

# Check whether the file already exists, and if so prompt about overwriting it
if [[ -f "$DEST/$LATEST_FILE" ]]; then
  OVERWRITE="$(prompt 'A file with the same name exists already. Replace it?' 'Replace')"
  if [[ ! $OVERWRITE == "Replace" ]]; then
    echo "Aborting"
    exit
  fi
fi

mv -f "$FROM_DIR/$LATEST_FILE" "$DEST"
open "$DEST"
echo $LATEST_FILE moved to $DEST
