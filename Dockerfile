FROM nousresearch/hermes-agent:latest

# Non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install chromium, python3-pip, and other utilities; install ddgs
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		git \
		unzip \
		python3-pip \
		chromium \
	&& rm -rf /var/lib/apt/lists/* \
	&& python3 -m pip install --no-cache-dir ddgs

# Set CHROME_BIN for tools that expect it
ENV CHROME_BIN=/usr/bin/chromium

# Workdir
WORKDIR /workspace

# Keep base image ENTRYPOINT/CMD
