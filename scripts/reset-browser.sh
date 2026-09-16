#!/usr/bin/env bash
# Repart d'un profil Chromium vierge : supprime le conteneur et en relance un neuf.
set -euo pipefail

docker rm -f chromium >/dev/null 2>&1 || true

docker run -d \
  --name chromium \
  --shm-size=1gb \
  -p 3000:3000 \
  -e TZ=Europe/Paris \
  -e KEYBOARD=fr-fr-azerty \
  lscr.io/linuxserver/chromium:latest

echo "Conteneur chromium recree. Ouvre le port 3000."
