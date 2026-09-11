#!/bin/bash

# 複数の動画を並列でダウンロードするためのスクリプト
title=$1
season=$2
amount=$3
base_url=$4

ytdlpdir=~/dev/yt-dlp-auto
number_of_cores=$(nproc)

echo "Title: $title"
echo "URL: $base_url"
echo "Amount: $amount"
echo "Season: $season"

cd "$ytdlpdir"

# for ((i=1; i<=amount; i++)); do
#   episode=$i

#   current_url="${base_url}${episode}"

#   echo "-------------------------------------------"
#   echo "Processing: ${title} - Episode ${episode}"
#   echo "Target URL: $current_url"
#   echo "-------------------------------------------"

#   # 下のスクリプトを呼び出す（引数は：タイトル、シーズン、エピソード番号(i)、現在のURL）
#   bash yt-dlp-auto-edit.sh "$title" "$season" "$episode" "$current_url"
# done

dl-loop() {
  local episode="$1"
  local title="$2"
  local season="$3"
  local amount="$4"
  local base_url="$5"
  local current_url="${base_url}${episode}"

  echo "-------------------------------------------"
  echo "Processing: ${title} - Episode ${episode}"
  echo "Target URL: $current_url"
  echo "-------------------------------------------"

  bash yt-dlp-auto-edit.sh "$title" "$season" "$episode" "$current_url"
}

export -f dl-loop

seq 1 "$amount" | parallel -j "$number_of_cores" dl-loop {} "$title" "$season" "$amount" "$base_url"