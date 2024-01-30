#!/bin/bash

TARGET_DIR=$1
cd $TARGET_DIR

# Get lists of files
readarray TARGET_DIR_FILES <<< "$(find "$TARGET_DIR" -maxdepth 1 -type f -printf '"%P"\n')"
readarray TARGET_DIR_DIRECTORIES <<< "$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d -printf '"%P"\n')"

TARGET_DIR_FILES="$(echo "${TARGET_DIR_FILES[@]}" | tr "\n" " ")"

# Get file sizes
readarray du_output <<< "$(bash -c "du -sh $TARGET_DIR_FILES 2> /dev/null" | sort -hr)"
for file in "${du_output[@]}"; do
  FILE_SIZES="$FILE_SIZES*$(cut -d ' ' -f 1 <(echo $file))"
  FILE_NAMES="$FILE_NAMES*$(cut -d ' ' -f 2- <(echo $file))"
done

TARGET_DIR_DIRECTORIES="$(echo "${TARGET_DIR_DIRECTORIES[@]}" | tr "\n" " ")"

readarray du_output <<< "$(bash -c "du -sh $TARGET_DIR_DIRECTORIES 2> /dev/null" | sort -hr)"
for directory in "${du_output[@]}"; do
  DIR_SIZES="$DIR_SIZES*$(cut -d ' ' -f 1 <(echo $directory))"
  DIR_NAMES="$DIR_NAMES*$(cut -d ' ' -f 2- <(echo $directory))"
done

FILE_SIZES="FS:${FILE_SIZES:1}"
FILE_NAMES="FN:${FILE_NAMES:1}"

DIR_SIZES="DS:${DIR_SIZES:1}"
DIR_NAMES="DN:${DIR_NAMES:1}"

echo $FILE_SIZES
echo $FILE_NAMES
echo $DIR_SIZES
echo $DIR_NAMES
