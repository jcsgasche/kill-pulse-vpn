#!/bin/bash

# Finds and kills the Pulse Secure VPN background service and UI.

if [[ $EUID -ne 0 ]]; then
   echo -e "\e[1;41mThis script must be run as root.\e[0m"
   exit 1
fi

IDS=$(ps -ax | grep -i 'pulse[ui|svc]' | tr -s ' ' | sed 's/^ *//g' | cut -d ' ' -f 1)

for ID in ${IDS[@]}; do
    echo -n "Killing $ID... "
    sudo kill -s 9 $ID
    echo done.
done

sudo echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4" | tee /etc/resolv.conf