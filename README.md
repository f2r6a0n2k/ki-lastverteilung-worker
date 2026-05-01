# KI-Lastverteilung Netzwerk - Worker Installationsdateien

Alle Skripte für die Lastverteilung im KI-Netzwerk.

## Dateien und Installationsanleitungen

### 1. `lastverteilung_ki_netzwerk.md`
- Konzeptdokument für das gesamte Projekt.

### 2. `install_worker_linux.sh`
- **Plattform**: Linux (Ubuntu/Debian)
- **Installation**:
  ```bash
  bash install_worker_linux.sh [PORT]
  # Beispiel: bash install_worker_linux.sh 8082
  ```

### 3. `install_worker_windows.ps1`
- **Plattform**: Windows (PowerShell)
- **Installation** (als Administrator):
  ```powershell
  .\install_worker_windows.ps1 [PORT]
  # Beispiel: .\install_worker_windows.ps1 8083
  ```

### 4. `install_worker_termux.sh`
- **Plattform**: Android (Termux)
- **Installation**:
  ```bash
  bash install_worker_termux.sh [PORT]
  # Beispiel: bash install_worker_termux.sh 8084
  ```

### 5. `monitor_load.sh`
- **Plattform**: Linux
- **Installation**:
  ```bash
  sudo apt install sshpass
  bash monitor_load.sh
  ```

### 6. `koordinator.py`
- **Plattform**: Alle (Python)
- **Installation**:
  ```bash
  pip install fastapi uvicorn requests
  uvicorn koordinator:app --host 0.0.0.0 --port 5000
  ```

## Standard-Modell
Alle Worker nutzen standardmäßig: **TinyLlama-1.1B-Chat (Q4_K_M quantisiert)** (~700MB)
