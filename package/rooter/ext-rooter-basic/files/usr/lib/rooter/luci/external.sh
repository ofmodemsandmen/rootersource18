#!/bin/sh

while [ true ]
do
	curl -k https://api.ipify.org?format=json > /tmp/xpip
	curl -k https://api.ipify.org?format=json > /tmp/xpip
	mv /tmp/xpip /tmp/ipip
	sleep 10
done