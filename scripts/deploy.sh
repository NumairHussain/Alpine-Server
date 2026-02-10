#!/bin/bash

STACK=$1
ACTION=$2

# Define stack locations
declare -A STACKS
STACKS[jellyfin]="/home/numair/services/jellyfin"
STACKS[pi-hole]="/home/numair/services/pi-hole"
STACKS[nginx]="/home/numair/services/nginx"
STACKS[olympus]="/home/numair/services/olympus"
STACKS[actual-budget]="/home/numair/services/actual-budget"

# Check if stack exists
if [[ ! -v "STACKS[$STACK]" ]]; then
    echo "Error: Stack '$STACK' not found"
    exit 1
fi

cd "${STACKS[$STACK]}"

# Execute action
case $ACTION in
    "Start")
        echo "Starting $STACK..."
        docker-compose up -d
        ;;
    "Stop")
        echo "Stopping $STACK..."
        docker-compose down
        ;;
    "Restart")
        echo "Restarting $STACK..."
        docker-compose restart
        ;;
    "Update")
        echo "Updating $STACK..."
        docker-compose pull && docker-compose up -d
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Available actions: Start, Stop, Restart, Update"
        exit 1
        ;;
esac