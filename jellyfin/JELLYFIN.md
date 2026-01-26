## Jellyfin

### **Services are not currently running**.

This is a Jellyfin server running in a Docker container using the `jellyfin/jellyfin` image.

## Updating the Server

To update the Jellyfin server, do the following

```bash
cd /jellyfin
docker compose down
docker pull jellyfin/jellyfin:latest
docker compose up -d
```

