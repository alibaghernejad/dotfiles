#!/usr/bin/env bash

# uncomment for debugging purposes (start tracing)
# set -x

# on cht.sh languages and core_utils have different url segments. 
# languages:  cht.sh/{language}/{query+string}
# example 1:  cht.sh/rust
# example 2:  cht.sh/rust/for+loop 
#
# core_utils: cht.sh/{tool}~[operation]
# example 1:  cht.sh/tar
# example 2:  cht.sh/tar~list
# check out cht.sh for more info.
#
languages=`echo "c cpp csharp fsharp golang rust zig javascript typescript nodejs" | tr ' ' '\n'`
core_utils=`echo "awk sed xargs tar ps" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
# echo $selected

# get user query
read -p "query: " query

# detect choosed language or core_util and do the cht.sh for that
#
# "%s\n" ensures one item per line.
# -F makes grep treat input as fixed strings (no regex).
# -x matches the whole line (exact match).
# Quoting $selected ensures it's treated as one argument.
#
if printf "$languages" | grep -qs "$selected"; then
#if printf "%s\n" $languages | grep -Fxqs "$selected"; then
  tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
else
  tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi    

# end debugging (stop tracing)
# set +x
