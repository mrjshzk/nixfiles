#!/usr/bin/env bash

prefix="$HOME/.config/"
terminal="ghostty"

chosen="$(printf "nvim\nquickshell\nnixos" | rofi -dmenu -p i'Edit configurations:')"

full_path="${prefix}${chosen}"
exec "$terminal" -e bash -c "cd \"$full_path\" && nvim ."
