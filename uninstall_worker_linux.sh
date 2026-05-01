#!/bin/bash
# Deinstallation Linux Worker
# Verwendung: bash uninstall_worker_linux.sh [PORT]
# Beispiel: bash uninstall_worker_linux.sh 8080

PORT=${1:-8080}
INSTALL_DIR="$HOME/llama_worker"

echo "=== LLAMA.CPP Worker Deinstallation (Linux) ==="

# Worker stoppen
pkill -f "llama-server.*$PORT"
sleep 2

# Firewall-Regel entfernen
sudo ufw delete allow "$PORT/tcp" 2>/dev/null

# Installationsverzeichnis löschen
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Verzeichnis $INSTALL_DIR gelöscht"
else
    echo "⚠️  Verzeichnis $INSTALL_DIR nicht gefunden"
fi

echo "✅ Worker auf Port $PORT deinstalliert"
