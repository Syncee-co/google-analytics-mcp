FROM python:3.11-slim

WORKDIR /app

# Python pufferelés kikapcsolása a stabil MCP kommunikációért
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Alapvető fordítóeszközök telepítése (opcionális, de biztonsági játék, ha valamelyik függőségnek kell)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Első lépésként a TELJES forráskódot másoljuk be, mert a pyproject.toml-nek szüksége van rá
COPY . .

# A projekt és az összes függőség telepítése a pyproject.toml alapján
RUN pip install --no-cache-dir .

# Belépési pont: a modern MCP projektek a pyproject.toml-ben definiálnak egy parancsot (console_script).
# Ez a repóban nagy valószínűséggel a "google-analytics-mcp" parancs lesz.
ENTRYPOINT ["google-analytics-mcp"]
