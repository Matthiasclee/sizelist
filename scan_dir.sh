#!/bin/bash

TARGET_DIR=$1

cd $TARGET_DIR

readarray TARGET_DIR_FILES <<< "$(find "$TARGET_DIR" -maxdepth 1 -type f -exec realpath --relative-to="$(pwd)" {} \;)"

readarray TARGET_DIR_DIRECTORIES <<< "$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d -exec realpath --relative-to="$(pwd)" {} \;)"

for file in "${TARGET_DIR_FILES[@]}"; do
  du -s "${file::-1}" 2> /dev/null | sort -gr
done

for file in "${TARGET_DIR_DIRECTORIES[@]}"; do
  du -s "${file::-1}" 2> /dev/null | sort -gr
done
