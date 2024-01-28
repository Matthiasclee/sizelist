TARGET_DIR=$1
TARGET_DIR_FILES=$(find $TARGET_DIR -maxdepth 1 -type f)
TARGET_DIR_DIRECTORIES=$(find $TARGET_DIR -mindepth 1 -maxdepth 1 -type d)

for file in "${TARGET_DIR_FILES[@]}"; do
  du -s $file
done
