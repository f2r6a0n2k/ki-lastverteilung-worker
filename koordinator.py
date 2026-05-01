# FastAPI Koordinator für Lastverteilung (Round-Robin)
# Verwendung: uvicorn koordinator:app --host 0.0.0.0 --port 5000
# Voraussetzung: pip install fastapi uvicorn requests

from fastapi import FastAPI
import requests

app = FastAPI()
WORKERS = ["http://192.168.178.105:8080", "http://192.168.178.109:8081"]
current_worker = 0

def get_next_worker():
    global current_worker
    worker = WORKERS[current_worker]
    current_worker = (current_worker + 1) % len(WORKERS)
    return worker

@app.post("/prompt")
async def handle_prompt(prompt: str, max_tokens: int = 100):
    worker = get_next_worker()
    try:
        resp = requests.post(f"{worker}/completion", json={"prompt": prompt, "max_tokens": max_tokens}, timeout=30)
        return {"worker": worker, "result": resp.json()}
    except Exception as e:
        return {"error": str(e), "worker": worker}
