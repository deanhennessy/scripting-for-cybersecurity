#!/bin/bash

P22=0
P80=0
P443=0
OTHER=0

while read -r ACTION SRC ARROW DST; do
    [ "$ACTION" = "BLOCK" ] || continue
    PORT=${DST##*:}
    PORT=${PORT%$'\r'}
    echo "$ACTION from $SRC to port $PORT"
    if [ "$PORT" -eq 22 ]; then
        P22=$((P22 + 1))
    elif [ "$PORT" -eq 80 ]; then
        P80=$((P80 + 1))
    elif [ "$PORT" -eq 443 ]; then
        P443=$((P443 + 1))
    else
        OTHER=$((OTHER + 1))
    fi
done < case/logs/firewall.log

echo "Blocked connections: port 22: $P22, port 80: $P80, port 443: $P443, other: $OTHER"
