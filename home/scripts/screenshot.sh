#!/usr/bin/env bash

mkdir -p ~/screenshots

chosen="$(printf 'region\nwindow\nmonitor' | rofi -dmenu -p "Take screenshot of:")"
hyprshot -m $chosen -o ~/screenshots

