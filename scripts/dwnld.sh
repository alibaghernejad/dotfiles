#!/usr/bin/env bash
#set -x
declare -A DWNLDPROVIDERS
DWNLDPROVIDERS["m3u8_stream"]='streamlink;'
# IMPORTANT: CHANGE THE FIREFOX TO YOUR APPROPRIATE VALUE
# It's used for youtibe auth.
DWNLDPROVIDERS["youtube"]='yt-dlp --cookies-from-browser firefox -f "best";'
SAVELOC="$HOME/Downloads"

header="What Download provider do you want to use?"

oldIFS=$ISF
IFS=";"
menu=()
  for k in "${!DWNLDPROVIDERS[@]}";do
menu+=(`echo "$k"`)
  done
IFS=$oldIFS

provider=`printf "%s\n" "${menu[@]}" | fzf --header=$header`

read -p "And the Url? " url
IFS=";" read -r -a arr <<< "${DWNLDPROVIDERS[$provider]}"
command="${arr[0]}"
echo "Choosed Provider: ${provider}"
echo "Backend: ${command}"

if [[ $provider == "m3u8_stream" ]]; then
  filename="$(basename "$url").ts"
  bash -c "$command \"$url\" best --output \"$filename\"" 
else
  bash -c "$command \"$url\"" 
fi

