#!/bin/bash

STACK=$1
ACTION=$2

# Define stack locations
ls -la

declare -A STACKS
STACKS[Jellyfin]="./jellyfin"
STACKS[Pi-Hole]="./pi-hole"
STACKS[Nginx]="./nginx"
STACKS[Olympus]="./olympus"
STACKS[Actual-Budget]="./actual-budget"

# Check if stack exists
if [[ ! -v "STACKS[$STACK]" ]]; then
    echo "Error: Stack '$STACK' not found"
    exit 1
fi

cd "${STACKS[$STACK]}"
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to navigate to stack directory"
    exit 1
fi

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