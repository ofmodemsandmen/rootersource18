#!/bin/sh

ROOTER=/usr/lib/rooter

log() {
	modlog "Check Connection $CURRMODEM" "$@"
}

CURRMODEM=$1

watch=$(uci -q get modem.modem$CURRMODEM.watchdog)
if [ -z "$watch" ]; then
	watch="0"
fi
if [ "$watch" = "0" ]; then
	log "Check Conn running"
	if [ -e /usr/lib/autoapn/apn.data ]; then
		timeout=10
	else
		if [ -e /usr/lib/country/mccdata ]; then
			timeout=10
		else
			timeout=7
		fi
	fi
	while [ $timeout -ge 0 ]; do
		conn=$(uci -q get modem.modem$CURRMODEM.connected)
		if [ "$conn" = '1' ]; then
			log "Normal Exit"
			exit 0
		fi
		log "$timeout"
		timeout=$((timeout-1))
		sleep 20
	done
	log "Modem Restart"
	$ROOTER/luci/restart.sh $CURRMODEM 11
fi