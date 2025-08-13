#!/usr/bin/env bash
# -r: revrse the sort order
# -t: sort by modification time
ls -t ~/zettelkasten/notes/pdf/*.pdf | head -n1 | xargs zathura

