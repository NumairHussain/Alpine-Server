#!/bin/bash

STACK=$1
ACTION=$2

# Define stack locations
declare -A STACKS
STACKS[Jellyfin]="./jellyfin"
STACKS[Pi-Hole]="./pi-hole"
STACKS[Nginx]="./nginx/nginx/conf.d"
STACKS[Olympus]="./olympus"
STACKS[Actual-Budget]="./actual-budget"

working_directory="$(dirname "$0")"
all_services_flag=false

# Check if stack exists
if [[ ! -v "STACKS[$STACK]" ]]; then
    echo "Error: Stack '$STACK' not found"
    exit 1
fi

if [[ "$STACK" == "All Services" ]]; then
    all_services_flag=true
    echo "Performing '$ACTION' on all services..."
else
    echo "Performing '$ACTION' on $STACK..."
    cd "${STACKS[$STACK]}"
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to navigate to stack directory"
        exit 1
    fi
fi 


# Execute action
case $ACTION in
    "Start")
        if [[ "$all_services_flag" == true ]]; then
            for key in "${!STACKS[@]}"; do
                dir="${STACKS[$key]}"
                echo "Starting $key (dir=$dir)..."
                (cd $dir && docker compose up -d)
            done
        else
            echo "Starting $STACK..."
            docker compose up -d
        fi
        ;;
    "Stop")
        if [[ "$all_services_flag" == true ]]; then
            for key in "${!STACKS[@]}"; do
                dir="${STACKS[$key]}"
                echo "Stopping $key (dir=$dir)..."
                (cd $dir && docker compose down)
            done
        else
            echo "Stopping $STACK..."
            docker compose down
        fi
        ;;
    "Restart")
        if [[ "$all_services_flag" == true ]]; then
            for key in "${!STACKS[@]}"; do
                dir="${STACKS[$key]}"
                echo "Stopping $key (dir=$dir)..."
                (cd $dir && docker compose restart)
            done
        else
            echo "Restarting $STACK..."
            docker compose restart
        fi
        ;;
    "Update")
        if [[ "$all_services_flag" == true ]]; then
            for key in "${!STACKS[@]}"; do
                dir="${STACKS[$key]}"
                echo "Stopping $key (dir=$dir)..."
                (cd $dir && docker compose pull && docker compose up -d)
            done
        else
            echo "Updating $STACK..."
            docker compose pull && docker compose up -d
        fi
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Available actions: Start, Stop, Restart, Update"
        exit 1
        ;;
esac