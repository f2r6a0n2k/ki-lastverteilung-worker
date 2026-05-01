# Video-Guide: KI-Lastverteilung Netzwerk einrichten (für NotebookLM)

## Skript für das Video (ca. 5-10 Minuten)

### Einleitung (30 Sek)
"Hallo und willkommen! In diesem Video zeige ich euch, wie ihr ein intelligentes KI-Netzwerk aus alten und neuen Geräten aufbaut. Wir nutzen llama.cpp, um KI-Modelle lokal auszuführen und die Rechenlast im Haushalt oder Unternehmen zu verteilen."

### Schritt 1: Projekt verstehen (1 Min)
- Zeige das Konzeptdokument `lastverteilung_ki_netzwerk.md`
- Erkläre die Komponenten: Koordinator, Worker, Kommunikation
- Modell: TinyLlama-1.1B (klein, effizient)

### Schritt 2: Linux Worker installieren (2 Min)
- Öffne Terminal
- Lade das Skript herunter oder erstelle es: `nano install_worker_linux.sh`
- Führe aus: `bash install_worker_linux.sh 8082`
- Zeige den Test: `curl http://localhost:8082/health`
- Erkläre: Worker läuft, Modell wird geladen

### Schritt 3: Windows Worker installieren (1.5 Min)
- Öffne PowerShell als Administrator
- Führe aus: `.\install_worker_windows.ps1 8083`
- Zeige Firewall-Regel und startenden Worker
- Test: `curl http://localhost:8083/health`

### Schritt 4: Android (Termux) Worker (1.5 Min)
- Installiere Termux aus F-Droid
- Führe aus: `bash install_worker_termux.sh 8084`
- Test: `curl http://localhost:8084/health`

### Schritt 5: Lastverteilung testen (2 Min)
- Start Koordinator: `uvicorn koordinator:app --host 0.0.0.0 --port 5000`
- Sende Anfragen: `curl -X POST http://KOORDINATOR:5000/prompt -H "Content-Type: application/json" -d '{"prompt":"Hallo","max_tokens":50}'`
- Zeige Monitoring: `bash monitor_load.sh`

### Schritt 6: Deinstallation (30 Sek)
- Linux: `bash uninstall_worker_linux.sh 8082`
- Windows: `.\uninstall_worker_windows.ps1 8083`
- Termux: `bash uninstall_worker_termux.sh 8084`

### Abschluss (30 Sek)
"So habt ihr ein dezentrales KI-Netzwerk aufgebaut. Alle Daten bleiben lokal, und ihr nutzt vorhandene Hardware optimal aus. Viel Spaß beim Experimentieren!"

## Hinweise für NotebookLM:
- Upload alle Dateien aus dem Ordner `KI_Lastverteilung_Worker`
- Füge diesen Guide als Quelle hinzu
- Lass dir ein Skript oder eine Zusammenfassung generieren
- Benutze die Audio-Option für Voiceover
