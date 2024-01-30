#!/bin/bash

TARGET_DIR=$1

readarray dir_scan_output <<< "$(bash ./scan_dir.sh $TARGET_DIR)"

FILE_SIZES="$(cut -d ':' -f 2 <(echo "${dir_scan_output[0]::-1}"))"
FILE_NAMES="$(cut -d ':' -f 2 <(echo "${dir_scan_output[1]::-1}"))"
DIR_SIZES="$(cut -d ':' -f 2 <(echo "${dir_scan_output[2]::-1}"))"
DIR_NAMES="$(cut -d ':' -f 2 <(echo "${dir_scan_output[3]::-1}"))"

