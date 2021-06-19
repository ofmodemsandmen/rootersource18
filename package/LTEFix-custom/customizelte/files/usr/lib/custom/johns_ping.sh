#!/bin/sh

. /lib/functions.sh
 
ROOTER=/usr/lib/rooter
ROOTER_LINK="/tmp/links"

log() {
logger -t "John's Ping Test " "$@"
}

ENB=$(uci get ping.ping.enable)
if [ $ENB = 0 ]; then
	exit 0
fi

# Perform 5 initial pings and exit the script if any of them are successful
tries=0
while [[ $tries -lt 5 ]]
do
    if /bin/ping -c 1 8.8.8.8 > /dev/null
    then
        #echo "$(date +%c) : Successful Ping" >> $ROOTER/log/connect.log
        exit 0
    fi
    #echo "$(date +%c) : Failed Ping" >> $ROOTER/log/connect.log
    sleep 10
    tries=$((tries+1))
done

# If all initial pings failed, then scan through possible modems (1 & 2)
modem_id=0
live_ports=0
failed_pings=0
while [[ $modem_id -lt 2 ]]
do
    # Check for active port associated with the modem ID
    CPORT=$(uci get modem.modem$modem_id.commport)
    if [ ! -z "$CPORT" ]; then
        # Send reset to the modem
        live_ports=$((live_ports+1))
        # ATCMDD="AT+CFUN=0;+CFUN=1,1"
        ATCMDD="AT!RESET"
        $ROOTER/gcom/gcom-locked "/dev/ttyUSB$CPORT" "run-at.gcom" "$modem_id" "$ATCMDD"
        #echo "$(date +%c) : Resetting modem $modem_id on port $CPORT" >> $ROOTER/log/connect.log

        # Delay 180s to give time for modem to come back alive
        sleep 180
        #echo "$(date +%c) : Ready to try second ping" >> $ROOTER/log/connect.log

        # Try a second ping and exit if modem reset corrected the connection problem
        if /bin/ping -c 1 8.8.8.8 > /dev/null
        then
            #echo "$(date +%c) : Successful Second Ping" >> $ROOTER/log/connect.log
            exit 0
        fi
        #echo "$(date +%c) : Failed Second Ping" >> $ROOTER/log/connect.log
        failed_pings=$((failed_pings+1))
    fi
    modem_id=$((modem_id+1))
done

# If any second pings failed then re-boot the router
if [ $failed_pings -gt 0 ]; then
    #echo "$(date +%c) : Rebooting Router due to failed second pings" >> $ROOTER/log/connect.log
    reboot -f
fi

# If there were no live ports then re-boot the router
if [ $live_ports -eq 0 ]; then
    #echo "$(date +%c) : Rebooting Router due to No Active Ports" >> $ROOTER/log/connect.log
    reboot -f
fi

