#!/bin/bash

TARGET_DIR=$1

while true; do
  SELECTION=$(bash ./list_data.sh $TARGET_DIR | fzf --reverse)
  if [ "$SELECTION" == "* Exit" ]; then
    break
  else
    TARGET_DIR=$(echo "$SELECTION" | cut -d ' ' -f 2-)
    cd $TARGET_DIR
    TARGET_DIR="."
  fi
done
