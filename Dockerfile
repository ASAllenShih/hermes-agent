FROM nousresearch/hermes-agent:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install Google Chrome and necessary dependencies, then install ddgs in a venv
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates curl wget gnupg lsb-release apt-transport-https \
    python3-venv python3-pip \
    fonts-liberation libappindicator3-1 libasound2 libatk1.0-0 libatk-bridge2.0-0 \
    libc6 libdrm2 libgbm1 libgtk-3-0 libnspr4 libnss3 libx11-6 libx11-xcb1 libxcb1 \
    libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 \
    libxrender1 libxss1 libxtst6 \
 && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-archive-keyring.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-archive-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends google-chrome-stable \
 && rm -rf /var/lib/apt/lists/* \
 # Create a venv for ddgs to avoid PEP 668 externally-managed-environment errors
 && /usr/bin/python3 -m venv /opt/ddgs-venv \
 && /opt/ddgs-venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel \
 && /opt/ddgs-venv/bin/pip install --no-cache-dir ddgs \
 && ln -s /opt/ddgs-venv/bin/ddgs /usr/local/bin/ddgs || true

ENV CHROME_BIN=/usr/bin/google-chrome-stable

WORKDIR /workspace

# Keep base image ENTRYPOINT/CMD
