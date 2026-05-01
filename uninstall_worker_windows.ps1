# Deinstallation Windows Worker (PowerShell - als Administrator ausführen)
# Verwendung: .\uninstall_worker_windows.ps1 [PORT]
# Beispiel: .\uninstall_worker_windows.ps1 8081

param([int]$Port = 8081)
$InstallDir = "$env:USERPROFILE\llama_worker"

Write-Host "=== LLAMA.CPP Worker Deinstallation (Windows) ==="

# Worker stoppen
Get-Process -Name "llama-server" -ErrorAction SilentlyContinue | Stop-Process -Force

# Firewall-Regel entfernen
Remove-NetFirewallRule -DisplayName "LLAMA $Port" -ErrorAction SilentlyContinue

# Installationsverzeichnis löschen
if (Test-Path $InstallDir) {
    Remove-Item -Recurse -Force $InstallDir
    Write-Host "✅ Verzeichnis $InstallDir gelöscht"
} else {
    Write-Host "⚠️  Verzeichnis $InstallDir nicht gefunden"
}

Write-Host "✅ Worker auf Port $Port deinstalliert"
