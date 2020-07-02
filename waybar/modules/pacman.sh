#!/bin/sh

num=$(checkupdates | wc -l)
case $num in
	"0") echo '';;
	*) echo $num ;;
esac

echo ''
echo ''
