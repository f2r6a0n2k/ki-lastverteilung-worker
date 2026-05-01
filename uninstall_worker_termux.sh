#!/bin/bash
# Deinstallation Android (Termux) Worker
# Verwendung: bash uninstall_worker_termux.sh [PORT]
# Beispiel: bash uninstall_worker_termux.sh 8082

PORT=${1:-8082}
INSTALL_DIR="$HOME/llama_worker"

echo "=== LLAMA.CPP Worker Deinstallation (Termux) ==="

# Worker stoppen
pkill -f "llama-server.*$PORT"
sleep 2

# Installationsverzeichnis löschen
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Verzeichnis $INSTALL_DIR gelöscht"
else
    echo "⚠️  Verzeichnis $INSTALL_DIR nicht gefunden"
fi

echo "✅ Worker auf Port $PORT deinstalliert"
