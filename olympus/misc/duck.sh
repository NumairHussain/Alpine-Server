#!/bin/sh

# DuckDNS domain and token
DOMAIN="mcolympus"
TOKEN="0a58088c-e1ed-4e8b-96c8-2afc16d1a1d6"

# Where to save logs
LOGFILE="./duck.log"

# Update DuckDNS
curl -k "https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip=" >> $LOGFILE 2>&1
echo "$(date) - Updated $DOMAIN" >> $LOGFILE
