#!/usr/bin/env bash

#preload = ~/.config/backgrounds/courbet.jpg
#wallpaper = , ~/.config/backgrounds/courbet.jpg

#find ~/dotfiles/backgrounds/.config/backgrounds/ -maxdepth 1 -type f

for file in ~/dotfiles/backgrounds/.config/backgrounds/*; do
    echo "$(basename ${file})"
done
