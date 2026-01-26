## Pi-hole

This is a Pi-hole server running in a Docker container using the `pihole/pihole` image.

## Updating the Server

To update the Pi-hole server, do the following

```bash
cd /pi-hole
docker compose down
docker pull pihole/pihole:latest
docker compose up -d
```