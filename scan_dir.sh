#!/bin/bash

#  | sort -gr to sort by size

TARGET_DIR=$1
cd $TARGET_DIR

# Get lists of files
readarray TARGET_DIR_FILES <<< "$(find "$TARGET_DIR" -maxdepth 1 -type f -exec realpath --relative-to="$(pwd)" {} \;)"
readarray TARGET_DIR_DIRECTORIES <<< "$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d -exec realpath --relative-to="$(pwd)" {} \;)"

# Get file sizes
FILE_SIZES=""
FILE_NAMES=""

DIR_SIZES=""
DIR_NAMES=""
for file in "${TARGET_DIR_FILES[@]}"; do
  du_output=$(du -sh "${file::-1}" 2> /dev/null)
  FILE_SIZES="$FILE_SIZES*$(cut -d ' ' -f 1 <(echo $du_output))"
  FILE_NAMES="$FILE_NAMES*$(cut -d ' ' -f 2 <(echo $du_output))"
done

for dir in "${TARGET_DIR_DIRECTORIES[@]}"; do
  du_output=$(du -sh "${dir::-1}" 2> /dev/null)
  DIR_SIZES="$DIR_SIZES*$(cut -d ' ' -f 1 <(echo $du_output))"
  DIR_NAMES="$DIR_NAMES*$(cut -d ' ' -f 2 <(echo $du_output))"
done


echo $FILE_SIZES
echo $FILE_NAMES
echo $DIR_SIZES
echo $DIR_NAMES
