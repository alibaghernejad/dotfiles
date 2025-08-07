#!/usr/bin/env bash

zk_loc=`echo "$HOME"/zettelkasten`
save_loc=`echo "$zk_loc"/notes`

file_name=$(echo "note-`date +"%D"`.md" | tr '/' '-')
file="$save_loc/$file_name"
echo "$zk_loc" "$save_loc" "$file_name" "$file"

if [[ ! -f "$file" ]]; then
  #echo "file not exists"
  mkdir -p $save_loc
  echo "# Notes of the Day-$(date +%Y-%m-%d)" > $file
fi

nvim -c "norm GO" \
  -c "norm Go## $(date +%H:%M)" \
  -c "norm G2o" \
  -c "norm zz" \
  -c "startinsert" $file

