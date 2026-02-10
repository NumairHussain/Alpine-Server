#!/bin/bash

STACK=$1
ACTION=$2

# Define stack locations
declare -A STACKS
STACKS[jellyfin]="/home/numair/services/jellyfin"
STACKS[pihole]="/home/numair/services/pi-hole"
STACKS[nginx]="/home/numair/services/nginx"
STACKS[actual-budget]="/home/numair/services/actual-budget"

# Check if stack exists
if [[ ! -v "STACKS[$STACK]" ]]; then
    echo "Error: Stack '$STACK' not found"
    exit 1
fi

cd "${STACKS[$STACK]}"

# Execute action
case $ACTION in
    "up")
        echo "Starting $STACK..."
        docker-compose up -d
        ;;
    "down")
        echo "Stopping $STACK..."
        docker-compose down
        ;;
    "restart")
        echo "Restarting $STACK..."
        docker-compose restart
        ;;
    "update")
        echo "Updating $STACK..."
        docker-compose pull && docker-compose up -d
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Available actions: up, down, restart, update, logs, status"
        exit 1
        ;;
esac