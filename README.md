# yt-dlp-auto
yt-dlpで動画用フォルダを作成しつつダウンロードするためのシェルスクリプト
mp4-trans-for-pspと一緒に使うと動画エンコードも自動化

# 使い方
sh yt-dlp-auto.sh title season episode https://mp4-url

WSLの場合、
```
sudo apt update
sudo apt install -y python3-venv

python3 -m venv ~/.local/share/yt-dlp-venv
~/.local/share/yt-dlp-venv/bin/python -m pip install -U "yt-dlp[default]"

~/.local/share/yt-dlp-venv/bin/python -c 'from Cryptodome.Cipher import AES; print("pycryptodomex: OK")'
~/.local/share/yt-dlp-venv/bin/yt-dlp --version
```
を実行し、最後の２行が成功することを確認して、
yt-dlpの呼び出しを
```
~/.local/share/yt-dlp-venv/bin/yt-dlp "$url" -o "${title}${season}-${episode}.%(ext)s"
```
に変更する必要がある