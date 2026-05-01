#!/bin/bash
# Linux (Ubuntu/Debian) Worker Installation
# Verwendung: bash install_worker_linux.sh [PORT] [MODELL-URL]
# Beispiel: bash install_worker_linux.sh 8082

PORT=${1:-8080}
MODEL_URL=${2:-"https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf"}
INSTALL_DIR="$HOME/llama_worker"

echo "=== LLAMA.CPP Worker Installation (Linux) ==="
sudo apt update && sudo apt install -y git build-essential cmake wget curl

mkdir -p "$INSTALL_DIR" && cd "$INSTALL_DIR"
git clone https://github.com/ggerganov/llama.cpp
cd llama.cpp && mkdir build && cd build && cmake .. && make -j$(nproc)

mkdir -p models && wget -q "$MODEL_URL" -O "models/tinyllama-q4.gguf"
sudo ufw allow "$PORT/tcp"

cat > "$INSTALL_DIR/start.sh" << INNER_EOF
#!/bin/bash
cd "$INSTALL_DIR/llama.cpp/build"
./bin/llama-server -m "$INSTALL_DIR/llama.cpp/models/tinyllama-q4.gguf" -c 1024 --port $PORT --host 0.0.0.0 -t \$(nproc) > /tmp/llama-worker.log 2>&1 &
INNER_EOF
chmod +x "$INSTALL_DIR/start.sh" && bash "$INSTALL_DIR/start.sh"

echo "✅ Worker läuft auf Port $PORT – Test: curl http://localhost:$PORT/health"
