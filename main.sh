#!/bin/bash

TARGET_DIR=$1

script_dir="$(dirname "$(readlink -f "$0")")"

cd "$TARGET_DIR"

while true; do
  TARGET_DIR="."
  SELECTION=$(bash "$script_dir/list_data.sh" "$TARGET_DIR" "$script_dir" | fzf --reverse)
  if [ "$SELECTION" == "* Exit" ]; then
    break
  elif [ "$SELECTION" == "* Back" ]; then
    cd ..
  else
    TARGET_DIR=$(echo "$SELECTION" | cut -d ' ' -f 2-)
    cd $TARGET_DIR
  fi
done
