#!/usr/bin/env bash
# capture specified region
grim -g "$(slurp -c '#FFFFFFFF')" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H:%M:%S').png --action-on-enter 'save-to-file'
