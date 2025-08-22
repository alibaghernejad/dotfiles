#!/usr/bin/env bash
# capture active window
read -r x y w h < <(
  hyprctl activewindow -j | jq -r '"\(.at[0]) \(.at[1]) \(.size[0]) \(.size[1])"'
)
#echo "$x $y $w $h"
region="`echo "${x},${y} ${w}x${h}"`"
#echo "$region"

grim -g "$region" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H:%M:%S').png --action-on-enter 'save-to-file'
