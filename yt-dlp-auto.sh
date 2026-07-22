#bin/bash
title=$1
season=$2
episode=$3
url=$4

echo "Title: $title"
echo "Season: $season"
echo "Episode: $episode"
echo "URL: $url"

cd ~/ビデオ

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
cd ~/dev/mp4-trans-for-psp
sh script.sh ~/ビデオ/"${title}"/"${season}"/"${title}${season}-${episode}.mp4" ~/ビデオ/"${title}"/"${season}"/"${title}${season}-${episode}-r.mp4"
echo "Video downloaded and converted successfully!"
