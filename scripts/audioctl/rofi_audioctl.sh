#!/bin/bash

# Define the items for the Rofi menu
items="mic toggle\nspeaker toggle"

# Show the Rofi menu and capture the selected item
selected_item=$(echo -e "$items" | rofi -dmenu -p "Select a distro option:")

# Print a message based on the selected item
case "$selected_item" in
"mic toggle")
~/dotfiles/scripts/audioctl/mic_toggle.sh
#notify-send "You selected Option 1"
;;
"speaker toggle")
  ~/dotfiles/scripts/audioctl/speaker_toggle.sh
;;
*)
notify-send "No valid option selected"
;;
esac


