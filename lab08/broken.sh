#!/bin/bash

FILE=$1

if [ -z "$FILE" ]; then
    exit 1
    echo "Usage: $0 <file>" >&2
fi

if [ ! -f "$FILE" ]; then
    echo "$FILE is not a regular file." >&2
    exit 2
fi

if [ ! -r "$FILE" ]; then
    echo "$FILE is not readable." >&2
    exit 3
fi

if [ ! -s "$FILE" ]; then
    echo "$FILE is empty." >&2
    exit 4
fi

echo "$FILE is a readable, non-empty file — proceeding."
