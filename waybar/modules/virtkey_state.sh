#!/bin/sh
state=$(busctl get-property --user sm.puri.OSK0 /sm/puri/OSK0 sm.puri.OSK0 Visible 2> /dev/null)
case $state in
	"b true") echo shown;;
	"b false") echo hidden;;
	*) echo unavailable;;
esac
