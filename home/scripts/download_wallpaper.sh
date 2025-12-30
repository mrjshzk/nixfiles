#!/usr/bin/env bash

url=$1
filename=$2

wget -O "${filename}" "${url}"
mv ./"${filename}" ~/dotfiles/backgrounds/.config/backgrounds/"${filename}"
