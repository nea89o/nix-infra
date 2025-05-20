#!/usr/bin/env bash
id=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?)  | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height) \(.id)"' | slurp -f %l)
swaymsg -t get_tree | jq -r ".. | select(.pid? and .id? and .id == $id)"
