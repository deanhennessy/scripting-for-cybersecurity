cat >> investigation.txt << 'EOF'

Exercise 4.2
The first if block checks whether any line mentions "for <username> ". The ! negates
grep -q, so the block runs when there is NO activity for that user. It exits early
because there is nothing to count, and it reports "no activity" with its own exit
code (3), which tells the caller this is not an error.

Exercise 4.3
The trailing space makes the pattern match the whole username. Without it,
"for admin" would also match "for administrator" or "for admin2", and "for root"
would match "for rootkit", so the counts would include the wrong accounts.
EOF#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <logfile> <username>" >&2
    exit 1
fi

LOGFILE=$1
USERNAME=$2

if [ ! -f "$LOGFILE" ]; then
    echo "Error: '$LOGFILE' not found" >&2
    exit 2
fi

if ! grep -q "for $USERNAME " "$LOGFILE"; then
    echo "$USERNAME: no activity found"
    exit 3
fi

FAILS=$(grep -c "Failed password for $USERNAME " "$LOGFILE")
ACCEPTS=$(grep -c "Accepted password for $USERNAME " "$LOGFILE")

if [ "$FAILS" -gt 0 ]; then
    echo "$USERNAME: $FAILS failed and $ACCEPTS accepted login(s) — investigate"
    if [ "$FAILS" -gt 5 ]; then
        echo "$USERNAME: HIGH RISK"
    fi
else
    echo "$USERNAME: $ACCEPTS successful login(s) only"
fi

exit 0
