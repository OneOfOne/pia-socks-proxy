#!/bin/sh
while true; do
	ps a | grep -q tun0 && break
	sleep 1s
done

killall -9 sockd 2>/dev/null

sockd -N 2 -D
