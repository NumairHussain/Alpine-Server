# Olympus Minecraft Bedrock Server

This is a Minecraft Bedrock server running in a Docker container using the `itzg/minecraft-bedrock-server` image.

## Updating the Server

To update the minecraft world, make a copy beforehand, then do the following

```bash
cd /olympus-server
docker compose down
docker pull itzg/minecraft-bedrock-server:latest
docker compose up -d
```