#!/bin/bash

TARGET_DIR=$1
script_dir=$2

readarray dir_scan_output <<< "$(bash "$script_dir/scan_dir.sh" "$TARGET_DIR")"

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

echo -e "\e[32m\e[1m* $(pwd)\e[39m\e[0m"
echo -e "\e[91m* Parent Directory\e[39m"
echo -e "\e[91m* Exit\e[39m"
echo
echo -e "\e[94m\e[1m$( echo -e "$DIR_NAMES_ALL" | sort -hr)\e[39m\e[0m"
echo
echo -e "\e[33m$( echo -e "$FILE_NAMES_ALL" | sort -hr)\e[39m"
