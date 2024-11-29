#!/usr/bin/env bash
#
# This script creates a pls file based on the folder passed as parameter (recursive)
#
# Example: ./build-pls.sh music/ music.pls
# Example: ./build-pls.sh jingles/ jingles.pls
#
# ###### # ###### # ###### # ###### # ###### # ###### # ###### # ###### # ###### # ###### # ###### # ######

MUSIC_DIR=$1
PLS_FILE=$2

# First we check if the user passed a folder as parameter
if [ -z "$MUSIC_DIR" ]; then
    echo "Usage: $0 <folder>"
    exit 1
fi

# Check if the second parameter contains the name of the pls file
if [ -z "$PLS_FILE" ]; then
    echo "Usage: $0 <folder> <pls file>"
    exit 1
fi

# We check if the folder exists
if [ ! -d "$MUSIC_DIR" ]; then
    echo "Folder $MUSIC_DIR does not exist"
    exit 1
fi

# We check if the folder is empty
if [ -z "$(ls -A $MUSIC_DIR)" ]; then
    echo "Folder $MUSIC_DIR is empty"
    exit 1
fi

# Clear the playlist file if it exists
if [ -f "$PLS_FILE" ]; then
    rm "$PLS_FILE"
fi

# We create the playlist file, only audio files are considered (mp3, ogg, wav, flac, opus, m4a, wma)
echo "[playlist]" > $PLS_FILE
elements=$(find "$MUSIC_DIR" -type f | grep -E "\.mp3$|\.ogg$|\.wav$|\.flac$|\.opus$|\.m4a$|\.wma$")
entries=$(echo "$elements" | wc -l)
echo "NumberOfEntries=$entries" >> $PLS_FILE
i=1
echo "$elements" | while IFS= read -r element; do
    echo "File$i=$element" >> $PLS_FILE
    i=$((i+1))
done

# Thats it, we have created the playlist file
echo "Playlist '$PLS_FILE' created with $entries entries"
