#!/bin/sh
case $(nmcli r wifi) in
	"enabled") nmcli r wifi off;;
	"disabled") nmcli r wifi on;;
esac
