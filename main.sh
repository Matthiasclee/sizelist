#!/bin/bash

if [ "$(which fzf)" == "" ]; then
  echo "Error: fzf must be installed." > /dev/stderr
  exit 1
fi

TARGET_DIR=$1

script_dir="$(dirname "$(readlink -f "$0")")"

cd "$TARGET_DIR"

while true; do
  TARGET_DIR="."
  SELECTION=$(bash "$script_dir/list_data.sh" "$TARGET_DIR" "$script_dir" | fzf --reverse --no-info --ansi)
  if [ "$SELECTION" == "* Exit" ]; then
    break
  elif [ "$SELECTION" == "* Back" ]; then
    cd ..
  else
    TARGET_DIR=$(echo "$SELECTION" | cut -d ' ' -f 2-)
    if [ -d "$TARGET_DIR" ]; then
      cd "$TARGET_DIR"
    fi
  fi
done
