#!/usr/bin/env bash

set -eu

# Set your terminal:
terminal="ghostty"

# Pick repo
configs="$(ls -1d "$HOME"/godot/*/ 2>/dev/null | xargs -n1 basename)"
[ -n "$configs" ] || exit 0
chosen="$(printf '%s\n' $configs | rofi -dmenu -p 'Godot projects:')"
[ -n "$chosen" ] || exit 0
dir="$HOME/godot/$chosen"

# Nuke any existing st (since you only use one terminal)
pkill -x $terminal 2>/dev/null || true
sleep 0.1

cd $dir
godot --display-driver wayland -e
