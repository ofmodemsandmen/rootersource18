#!/bin/sh

if [ -e /usr/lib/multiuser/multiuser.sh ]; then
	/usr/lib/multiuser/multiuser.sh $1
fi