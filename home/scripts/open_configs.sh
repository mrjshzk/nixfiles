#!/usr/bin/env bash

prefix="$HOME/.config/"
terminal="ghostty"

chosen="$(printf "nvim\nquickshell\nnixos" | rofi -dmenu -p 'Edit configurations:')"
echo $chosen
[ -n "$chosen" ] || exit 0

full_path="${prefix}${chosen}"
exec "$terminal" -e bash -c "cd \"$full_path\" && nvim ."
