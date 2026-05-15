#!/usr/bin/env bash

# =====
# 3-3000-fetcher
# Is the utility, which fetchs the materials of the english course from asriran CDNs.
# The course is based on the book "Oxford 3000 Core Words".
# It's 30x faster to download material with this tool in compare to manually downloading them.
# =====

# Check if the url argument is provided or not.
# Return with error in case of no url
if test -z "$1" ; then
  echo "Usage: ./3-3000-fetcher.sh URL"  
 exit 1 
fi

DOWNLOAD_URL="$1"
#TMP_DIR="/tmp/tmp.bqxOVW4iFf" 
TMP_DIR="$(mktemp -d)"
HTML_FILE_NAME="3-3000-lesson.htm"
WORD_FILE_NAME="3-3000-lesson-words.htm"
MP3_FILE_NAME="3-3000-lesson-files.txt"
# Check if the url argument is provided or npt.
# Return with error in case of no url
[ -v "$DOWNLOAD_URL" ] && echo "No URL is specifie." || echo "The URL recieved."

echo "Fetching the materials at URL: $DOWNLOAD_URL"
wget -O "$TMP_DIR/$HTML_FILE_NAME" "$DOWNLOAD_URL"

echo "Extracting metadata..."

# due to this fact that html tags like <h2> can have attributes,
# We process the <h2> tags as half-open manner nd pipe the result to capture the actual value.
# This a heuristic algorithm that works well with 3-3000-fetcher and it's data source.
# Consider even rows. Even row are english words.
cat "$TMP_DIR/$HTML_FILE_NAME" | tr "\n" -d| grep -oP '(?<=<td>-<h2).*?(?=/h2>-</td>)'| grep -oP '(?<=>).*?(?=<)' | tr '\n' ':' | awk -F: '{print $2, $4, $6, $8, $10,$12,$14,$16,$18, $20, $22, $24, $26}' > "$TMP_DIR/$WORD_FILE_NAME"

echo "Extracting audio files..."

cat "$TMP_DIR/$HTML_FILE_NAME" | tr "\n" -d| grep -oP '(?<=<source src=").*?(?=" type="audio/mp3")' > "$TMP_DIR/$MP3_FILE_NAME"

WORDS=`cat "$TMP_DIR/$WORD_FILE_NAME"`
WORDS= echo $WORDS | tr ' ' '\n' 
FILES=`cat "$TMP_DIR/$MP3_FILE_NAME"`
MP3_CHUNK_SIZE=3 # for each word in the lesson, there are 3 audio file.
IDX=0

# uncomment to tracing
#echo $WORDS
#echo $FILES

for WORD in ${WORDS[@]}
do
  #MP3_CHINK=`tail -n +$(($IDX*$MP3_CHUNK_SIZE)) "$TMP_DIR/$MP3_FILE_NAME"`
  MP3_CHUNK=`tail -n +$((($IDX*$MP3_CHUNK_SIZE)+1)) "$TMP_DIR/$MP3_FILE_NAME" | head -n $MP3_CHUNK_SIZE | tr ' ' '\n'` 
  MP3_IDX=1
  for MP3 in ${MP3_CHUNK} 
  do
  # no -i flag used, while the file is downloading one by one.
  `wget $MP3 -O $WORD"_en_us_"$MP3_IDX".mp3" &`
  MP3_IDX=$(($MP3_IDX+1))
  done
  
  IDX=$(($IDX+1))
  echo "Fetchin word $IDX..."
  echo "============================"
done


# uncomment for tracing purposes
#cat "$TMP_DIR/$MP3_FILE_NAME"

# download files at once
#wget -i "$TMP_DIR/$MP3_FILE_NAME" 

