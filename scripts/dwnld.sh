#!/usr/bin/env bash
#set -x
declare -A DWNLDPROVIDERS
DWNLDPROVIDERS["m3u8_stream"]='streamlink;'
DWNLDPROVIDERS["youtube"]='yt-dlp --cookies-from-browser firefox -f "best";'
DWNLDTYPE=`echo "m3u8_stream YouTube" | tr ' ' '\n'`
SAVELOC="$HOME/Downloads"
#echo "$DWNLDTYPE"
#echo ${DWNLDPROVIDERS[*]}

header="What Download provider do you want to use?"
#echo "selected: $selectedprovider"
#echo "${DWNLDPROVIDERS["$selectedprovider"]}"

oldIFS=$ISF
IFS=";"
menu=()
  for k in "${!DWNLDPROVIDERS[@]}";do
#    IFS=";" read -r -a arr <<< "${p}"
menu+=(`echo "$k"`)
  done
IFS=$oldIFS

provider=`printf "%s\n" "${menu[@]}" | fzf --header=$header`

read -p "And the Url? " url
IFS=";" read -r -a arr <<< "${DWNLDPROVIDERS[$provider]}"
command="${arr[0]}"
#filename=$(date +'%Y-%m-%d_%H-%M-%S')
filename="$(basename "$url").ts"
echo "Choosed Provider: ${provider}"
echo "Backend: ${command}"

if [[ $provider == "m3u8_stream" ]]; then
  
  bash -c "$command \"$url\" best --output \"$filename\"" 
else
  bash -c "$command \"$url\"" 
fi

