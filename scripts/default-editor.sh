#!/usr/bin/env bash

# Set the default editor for $EDITOR and $VISUAL 
# Based on the preference

# 1. Define your editor priority list here
# Order: Most preferred -> Fallbacks
EDITORS=("nvim" "vim" "nano" "vi")

# Loop through the list
# Detect the first available editor
for editor in "${EDITORS[@]}"; do
    # Check if the editor is installed
    if command -v "$editor" >/dev/null 2>&1; then
        # Run the editor and pass ALL arguments ($@) 
        # This is crucial so 'git commit -m "msg"' works correctly for example
        export EDITOR="$editor"
        export VISUAL="$editor"
        break
    fi
done

# 2. The Safety Net
# Even though the EDITOR variable itself can play a falback role ver well
# I'd rather to add a Safety Net here to fallback to most common available default.
# If EDITOR is still empty, try the universal POSIX default
if [ -z "$EDITOR" ]; then  
  echo "default-editor: No preferred editors found." >&2
  if command -v vi >/dev/null 2>&1; then
        export EDITOR="vi"
        export VISUAL="vi"
    else
        echo "default-editor: Failed to set default editor. No editor found on system?" >&2
    fi
fi
