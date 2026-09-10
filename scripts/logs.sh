#!/usr/bin/env bash
# Suit les logs du conteneur Chromium.
set -euo pipefail

docker logs -f chromium
