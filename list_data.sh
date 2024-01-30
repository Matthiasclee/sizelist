#!/bin/bash

TARGET_DIR=$1

readarray dir_scan_output <<< "$(bash ./scan_dir.sh $TARGET_DIR)"

IFS="*" read -a FILE_SIZES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[0]::-1}"))"
IFS="*" read -a FILE_NAMES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[1]::-1}"))"
IFS="*" read -a DIR_SIZES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[2]::-1}"))"
IFS="*" read -a DIR_NAMES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[3]::-1}"))"

DIR_NAMES_ALL=""

for index in "${!DIR_NAMES[@]}"; do
  DIR_NAMES_ALL="$DIR_NAMES_ALL\n${DIR_SIZES[$index]} ${DIR_NAMES[$index]}"
done

FILE_NAMES_ALL=""

for index in "${!FILE_NAMES[@]}"; do
  FILE_NAMES_ALL="$FILE_NAMES_ALL\n${FILE_SIZES[$index]} ${FILE_NAMES[$index]}"
done

echo -e "$DIR_NAMES_ALL" | sort -hr
echo -e "$FILE_NAMES_ALL" | sort -hr
