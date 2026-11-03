#!/bin/bash

CLIENTS=$(awk '{print $1}' case/logs/access.log | sort -u)

for IP in $CLIENTS; do
    COUNT=$(awk -v ip="$IP" '$1 == ip' case/logs/access.log | wc -l)

    if [[ "$IP" == 10.* || "$IP" == 192.168.* || "$IP" == 127.* || "$IP" == 172.1[6-9].* || "$IP" == 172.2?.* || "$IP" == 172.3[01].* ]]; then
        SCOPE="internal"
    else
        SCOPE="EXTERNAL"
    fi

    if grep -qxF "$IP" intel/iocs.txt; then
        echo "$IP ($COUNT requests, $SCOPE): already in IOC list"
    else
        echo "$IP ($COUNT requests, $SCOPE): NOT in IOC list"
    fi
done
