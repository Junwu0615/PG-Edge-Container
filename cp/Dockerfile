# --- 第一階段：編譯環境 (Builder) ---
FROM python:3.12-slim AS builder

WORKDIR /install

# 1. 安裝編譯工具
# 2. 執行 pip 安裝
# 3. 安裝完後立刻清理編譯工具，減少層的體積
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libpq-dev \
    git \
    librdkafka-dev \
    && pip install --upgrade pip \
    && pip install --prefix=/install git+https://github.com/Junwu0615/PG-Shared-Lib@main \
    && apt-get purge -y --auto-remove gcc python3-dev git \
    && rm -rf /var/lib/apt/lists/*


# --- 第二階段：執行環境 (Runtime) ---
FROM python:3.12-slim

WORKDIR /app

# 僅安裝運行時必要的動態庫
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    librdkafka1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 從 Builder 複製乾淨的 site-packages (不含編譯殘渣)
COPY --from=builder /install /usr/local

# 複製原始碼
COPY ./PG-APP-Core/src /app/src

# 環境變數設置
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH="/app"

ENTRYPOINT ["python", "src/core/v2/cp/main.py"]