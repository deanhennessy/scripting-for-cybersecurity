#!/bin/bash

COUNT=1

while [ "$COUNT" -le 5 ]; do
    echo "still scanning... (pass $COUNT)"
    COUNT=$((COUNT + 1))
done

echo "scan complete"
