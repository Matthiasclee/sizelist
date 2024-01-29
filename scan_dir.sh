#!/bin/bash

#  | sort -gr to sort by size

TARGET_DIR=$1
cd $TARGET_DIR

# Get lists of files
readarray TARGET_DIR_FILES <<< "$(find "$TARGET_DIR" -maxdepth 1 -type f -printf '%P\n')"
readarray TARGET_DIR_DIRECTORIES <<< "$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%P\n')"

# Get file sizes
for file in "${TARGET_DIR_FILES[@]}"; do
  du_output=$(du -sh "${file::-1}" 2> /dev/null)
  FILE_SIZES="$FILE_SIZES*$(cut -d ' ' -f 1 <(echo $du_output))"
  FILE_NAMES="$FILE_NAMES*$(cut -d ' ' -f 2- <(echo $du_output))"
done

for dir in "${TARGET_DIR_DIRECTORIES[@]}"; do
  du_output=$(du -sh "${dir::-1}" 2> /dev/null)
  DIR_SIZES="$DIR_SIZES*$(cut -d ' ' -f 1 <(echo $du_output))"
  DIR_NAMES="$DIR_NAMES*$(cut -d ' ' -f 2- <(echo $du_output))"
done

FILE_SIZES="FS:${FILE_SIZES:1}"
FILE_NAMES="FN:${FILE_NAMES:1}"

DIR_SIZES="DS:${DIR_SIZES:1}"
DIR_NAMES="DN:${DIR_NAMES:1}"

echo $FILE_SIZES
echo $FILE_NAMES
echo $DIR_SIZES
echo $DIR_NAMES
