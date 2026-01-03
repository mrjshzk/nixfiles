#!/usr/bin/env bash

layout=$1 # should be pt or us
# 1 - pt ; 0 - us | according to their definition order in hyprland config
declare -A layout_mapping
layout_mapping["pt"]=1
layout_mapping["us"]=0
notify-send "changed layout to ${layout}"
hyprctl switchxkblayout all ${layout_mapping[${layout}]}
