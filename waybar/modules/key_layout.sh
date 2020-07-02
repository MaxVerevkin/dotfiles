#!/bin/sh

layout=$(swaymsg -t get_inputs | jq '.[] | select(.identifier == "1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name' | tr -d '"')

case $layout in
	"English (US)")
		echo 'EN'
		echo ''
		echo 'en'
		;;
	"English (Dvorak)")
		echo 'DV'
		echo ''
		echo 'en'
		;;
	"Russian")
		echo 'RU'
		echo ''
		echo 'ru'
		;;
	*)
		echo '??'
		echo $layout
		echo 'unknown'
		;;
esac
