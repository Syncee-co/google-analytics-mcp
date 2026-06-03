FROM python:3.11-slim

WORKDIR /app

# A Python pufferelés kikapcsolása, hogy az MCP stdio kommunikáció azonnali legyen
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Rendszerfüggőségek telepítése (ha a csomagok fordításához szükséges lenne, pl. gcc)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Függőségek másolása és telepítése
# (A projekt felépítésétől függően ez lehet requirements.txt vagy pyproject.toml)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# A teljes forráskód bemásolása
COPY . .

# Ha a csomagot helyileg is telepíteni kell (pl. szerkeszthető módban)
# RUN pip install -e .

# Az MCP szerver indítása standard input/output módban
# (Ha a modul neve eltér, pl. src.main, írd át arra!)
ENTRYPOINT ["python", "-m", "google_analytics_mcp"]
