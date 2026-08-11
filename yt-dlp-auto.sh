#!/bin/bash
title=$1
season=$2
episode=$3
url=$4

video_dir=/yourvideodir
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
# abemaおよびyoutube以外で長時間の動画をダウンロードする場合、ffmpegでの結合にCPUが使われると時間がかかるので
# 下2行のコマンドを代わりに有効化して音声と動画を別でダウンロードしたあと、別でGPUエンコードしたほうがはやいが、ファイルサイズが大きくなる場合がある
# yt-dlp -f "ba[ext=m4a]" "$url" -o "${title}${season}-${episode}_audio.%(ext)s"
# yt-dlp -f "bv[ext=mp4]" "$url" -o "${title}${season}-${episode}_video.%(ext)s"
yt-dlp "$url" -o "${title}${season}-${episode}.mp4"

# PSP用に変換
cd "$mp4_trans_dir"
sh script.sh "$video_dir/${title}/${season}/${title}${season}-${episode}.mp4" "$video_dir/${title}/${season}/${title}${season}-${episode}-r.mp4"

if [ $? -eq 0 ]; then
  echo "Conversion successful!"
else
  echo "Conversion failed!"
  exit 1
fi
