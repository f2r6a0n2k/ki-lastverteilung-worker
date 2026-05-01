#!/bin/bash
# Echtzeit-Monitoring für Lastverteilung
# Verwendung: bash monitor_load.sh
# Voraussetzung: sshpass installiert (sudo apt install sshpass)

while true; do
  clear
  echo "=== Lastverteilung Monitor $(date +%T) ==="
  echo -e "\n📍 Elitebook (192.168.178.105:8080)"
  sshpass -p "cornholio" ssh -o StrictHostKeyChecking=no user@192.168.178.105 "top -b -n1 | head -4" 2>/dev/null
  curl -s --connect-timeout 2 http://192.168.178.105:8080/health >/dev/null && echo "  Worker: ✅ aktiv" || echo "  Worker: ❌ inaktiv"
  
  echo -e "\n📍 Aktueller Rechner (192.168.178.109:8081)"
  top -b -n1 | head -4
  curl -s --connect-timeout 2 http://192.168.178.109:8081/health >/dev/null && echo "  Worker: ✅ aktiv" || echo "  Worker: ❌ inaktiv"
  
  echo -e "\n📊 Inferenz-Test:"
  for worker in "192.168.178.105:8080" "192.168.178.109:8081"; do
    start=$(date +%s%N)
    curl -s --connect-timeout 3 -X POST "http://$worker/completion" -H "Content-Type: application/json" -d '{"prompt":"Hi","max_tokens":5}' >/dev/null 2>&1
    end=$(date +%s%N)
    dur=$(( (end - start) / 1000000 ))
    echo "  $worker: ${dur}ms"
  done
  sleep 5
done
