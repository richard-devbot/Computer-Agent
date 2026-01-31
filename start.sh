#!/bin/bash
# Startup script for OpenClaw on Render
# This script substitutes environment variables in openclaw.docker.json before starting the gateway

set -e

CONFIG_TEMPLATE="/app/openclaw.docker.json"
CONFIG_OUTPUT="/root/.openclaw/openclaw.json"

echo "==> Preparing OpenClaw configuration..."

# Create config directory
mkdir -p /root/.openclaw

# Substitute environment variables in config
envsubst < "$CONFIG_TEMPLATE" > "$CONFIG_OUTPUT"

echo "==> Configuration prepared:"
echo "   Ollama URL: ${OLLAMA_BASE_URL}"
echo "   WhatsApp Phone: ${WHATSAPP_PHONE}"
echo "   Gateway Port: 18789"

# Start OpenClaw gateway
echo "==> Starting OpenClaw gateway..."
exec openclaw gateway --force --no-daemon
