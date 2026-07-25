#!/bin/bash
title=$1
season=$2
episode=$3
url=$4

video_dir=/Users/w477/Movies/TV/Media.localized
mp4_trans_dir=~/dev/mp4-trans-for-psp

echo "Title: $title"
echo "Season: $season"
echo "Episode: $episode"
echo "URL: $url"

cd "$video_dir"

# ビデオディレクトリに移動し、タイトルのディレクトリが存在しない場合は作成する
if [ ! -d "${title}" ]; then
  mkdir "${title}"
fi
cd "${title}"

# シーズンディレクトリが存在しない場合は作成する
if [ ! -d "${season}" ]; then
  mkdir "${season}"
fi
cd "${season}"

# yt-dlpでダウンロード
yt-dlp --recode-video mp4 "$url" -o "${title}${season}-${episode}.mp4"

# PSP用に変換
cd "$mp4_trans_dir"
sh script.sh "$video_dir/${title}/${season}/${title}${season}-${episode}.mp4" "$video_dir/${title}/${season}/${title}${season}-${episode}-r.mp4"

if [ $? -eq 0 ]; then
  echo "Conversion successful!"
else
  echo "Conversion failed!"
  exit 1
fi
