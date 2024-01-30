#!/bin/bash

TARGET_DIR=$1

readarray dir_scan_output <<< "$(bash ./scan_dir.sh $TARGET_DIR)"

IFS="*" read -a FILE_SIZES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[0]::-1}"))"
IFS="*" read -a FILE_NAMES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[1]::-1}"))"
IFS="*" read -a DIR_SIZES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[2]::-1}"))"
IFS="*" read -a DIR_NAMES <<< "$(cut -d ':' -f 2 <(echo "${dir_scan_output[3]::-1}"))"


