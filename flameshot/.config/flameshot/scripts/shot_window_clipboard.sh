#!/usr/bin/env bash
# capture active window and send to clipboard.
read -r x y w h < <(
  hyprctl activewindow -j | jq -r '"\(.at[0]) \(.at[1]) \(.size[0]) \(.size[1])"'
)
echo "$x $y $w $h"
region="'`echo "${w}x${h}+${x}+${y}"`'"
echo "$region"
flameshot screen --region $region -c 

