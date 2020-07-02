#!/bin/sh

case $(/home/max/.config/waybar/modules/virtkey_state.sh) in
	"unavailable") echo '';;
	*) echo '';;
esac

echo ''
echo ''
