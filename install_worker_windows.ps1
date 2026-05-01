# Windows Worker Installation (PowerShell - als Administrator ausführen)
# Verwendung: .\install_worker_windows.ps1 [PORT]
# Beispiel: .\install_worker_windows.ps1 8083

param([int]$Port = 8081)
$InstallDir = "$env:USERPROFILE\llama_worker"
$LlamaUrl = "https://github.com/ggerganov/llama.cpp/releases/download/b3980/llama-b3980-bin-win-cpu-x64.zip"
$MODEL_URL = "https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf"

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
Invoke-WebRequest -Uri $LlamaUrl -OutFile "$InstallDir\llama.zip"
Expand-Archive -Path "$InstallDir\llama.zip" -DestinationPath $InstallDir -Force
Remove-Item "$InstallDir\llama.zip"

New-Item -ItemType Directory -Force -Path "$InstallDir\models" | Out-Null
Invoke-WebRequest -Uri $MODEL_URL -OutFile "$InstallDir\models\tinyllama-q4.gguf"
New-NetFirewallRule -DisplayName "LLAMA $Port" -Direction Inbound -LocalPort $Port -Protocol TCP -Action Allow -ErrorAction SilentlyContinue

$StartScript = "$InstallDir\start_worker.bat"
@"
@echo off
cd /d "$InstallDir\llama-b3980-bin-win-cpu-x64"
llama-server.exe -m "$InstallDir\models\tinyllama-q4.gguf" -c 1024 --port $Port --host 0.0.0.0 -t %NUMBER_OF_PROCESSORS%
"@ | Out-File -FilePath $StartScript -Encoding ASCII

Start-Process -FilePath $StartScript -WindowStyle Hidden
Write-Host "✅ Worker läuft auf Port $Port – Test: curl http://localhost:$Port/health"
