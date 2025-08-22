#!/usr/bin/env bash
# capture current display.
grim -g "$(slurp -o -r -c '#FFFFFFFF')" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H:%M:%S').png --action-on-enter 'save-to-file'
