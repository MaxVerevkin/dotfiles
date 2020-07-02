#!/bin/sh
case $(/home/max/.config/waybar/modules/virtkey_state.sh) in
	"shown") busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b false;;
	"hidden") busctl call --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 SetVisible b true;;
esac
