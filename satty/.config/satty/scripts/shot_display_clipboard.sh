#!/usr/bin/env bash
# capture current display and send to clipboard.
grim -g "$(slurp -o -r -c '#FFFFFFFF')" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H:%M:%S').png --actions-on-enter 'save-to-clipboard'
