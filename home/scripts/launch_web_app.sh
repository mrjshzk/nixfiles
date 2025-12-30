#!/bin/bash
# librewolf-webapp.sh
# Usage: ./librewolf-webapp.sh "https://some.url"

if [ -z "$1" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

URL="$1"

librewolf --new-window "$URL"
