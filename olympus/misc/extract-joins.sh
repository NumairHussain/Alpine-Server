#!/bin/sh
docker logs -f minecraft_bedrock 2>&1 | grep --line-buffered -E "Player (connected|disconnected)" >> ./player_activity.log
