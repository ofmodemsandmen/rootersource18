#!/bin/sh

log() {
	logger -t "Multiuser" "$@"
}

name=$1
uname=$(uci -q get rpcd.user.username)

multi=$(uci -q get custom.multiuser)
if [ -z "$multi" ]; then
	uci set custom.multiuser='multi'
	uci set custom.multiuser.multi="0"
fi
uci set custom.multiuser.name=$name
uci commit custom
	
if [ $name = "$uname" ]; then
#	for file in /usr/lib/multiuser/user/*.json
#	do
#		if [[ -f $file ]]; then
#			cp $file /usr/share/luci/menu.d/
#		fi
#	done
#	cp /usr/lib/multiuser/user/flash-min.js /www/luci-static/resources/view/system/
#	cp /usr/lib/multiuser/user/system1.js /www/luci-static/resources/view/system/
	uci set custom.multiuser.multi="1"
	uci set custom.multiuser.root="0"
	uci commit custom
fi
if [ $name = "root" ]; then
#	for file in /usr/lib/multiuser/root/*.json
#	do
#		if [[ -f $file ]]; then
#			cp $file /usr/share/luci/menu.d/
#		fi
#	done
	uci set custom.multiuser.multi="1"
	uci set custom.multiuser.root="1"
	uci commit custom
fi
