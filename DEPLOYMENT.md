# Dual Deployment Guide: Local + Render

This guide shows how to run OpenClaw in **two environments**:
- **Local (Mac)**: For development, WhatsApp integration, and local Ollama testing
- **Render (Cloud)**: For 24/7 production deployment with remote Ollama

---

## Local Setup (Mac)

### Prerequisites
- ✅ OpenClaw installed (`npm install -g openclaw`)
- ✅ Ollama running locally (`ollama serve`)
- ✅ Models pulled: `ollama pull qwen3-vl:4b` and `ollama pull nomic-embed-text`

### Configuration
Your local config is at: `~/.openclaw/openclaw.json`

It's configured to use:
- **Local Ollama**: `http://127.0.0.1:11434/v1`
- **WhatsApp**: Personal number `+919618089879`
- **Memory**: Ollama `nomic-embed-text` for embeddings

### Start Local Gateway

```bash
# Start gateway (auto-connects WhatsApp)
openclaw gateway --force

# In another terminal, check status
openclaw status

# View logs
openclaw logs --follow
```

### Test WhatsApp
1. Send "Hi" to your WhatsApp number
2. Agent should reply using local Ollama `qwen3-vl:4b`

---

## Render Deployment (Cloud)

### Prerequisites
- ✅ Render account (free tier available)
- ✅ GitHub account
- ✅ Remote Ollama server via ngrok

### Setup Steps

#### 1. Update Ngrok URL

Your current ngrok URL: `https://85a10ae4dca6.ngrok-free.app`

> [!WARNING]
> **Free ngrok URLs expire when restarted!**I'll share the one that was available to me at that timeFor 24/7 hosting, you need:
> - ngrok paid plan (static domain)
> - OR host Ollama on a VPS with public IP
> - OR use alternative tunneling (Cloudflare Tunnel, Tailscale Funnel)

#### 2. Push to GitHub

```bash
cd /Users/richardsongunde/projects/openclaw

# Create .gitignore (if not exists)
cat > .gitignore << 'EOF'
node_modules
.env
.env.local
*.log
.openclaw
logs
dist
*.swp
EOF

# Initialize git
git init
git add .
git commit -m "OpenClaw Render deployment"

# Create GitHub repo and push
git remote add origin https://github.com/YOUR-USERNAME/openclaw-render.git
git branch -M main
git push -u origin main
```

#### 3. Deploy to Render

1. Go to [render.com](https://render.com) and sign in
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub repository
4. Render will detect `render.yaml` and prompt for environment variables

**Set these environment variables:**

| Key | Value | Notes |
|-----|-------|-------|
| `SETUP_PASSWORD` | `your-secure-password` | For first-time setup |
| `OLLAMA_BASE_URL` | `https://85a10ae4dca6.ngrok-free.app/v1` | Your ngrok URL |
| `PORT` | `8080` | Required by Render |

5. Click **"Apply"** to deploy

#### 4. Configure via Setup Wizard

Once deployed, navigate to:
```
https://YOUR-SERVICE-NAME.onrender.com/setup
```

1. Enter your `SETUP_PASSWORD`
2. Select **"Custom OpenAI-compatible API"**
3. Base URL: `https://85a10ae4dca6.ngrok-free.app/v1`
4. API Key: `ollama` (any value works for Ollama)
5. Model: `qwen3-vl:4b`
6. Click "Save Configuration"

---

## Comparison

| Feature | Local (Mac) | Render (Cloud) |
|---------|-------------|----------------|
| **Ollama** | Local `127.0.0.1:11434` | Remote ngrok URL |
| **WhatsApp** | ✅ Full support | ⚠️ Requires workaround |
| **Uptime** | When Mac is on | 24/7 (paid plan) |
| **Cost** | Free | Free tier / $7/month |
| **Performance** | Faster (local) | Depends on ngrok latency |
| **Use Case** | Development, testing | Production, always-on |

---

## WhatsApp on Render (Advanced)

WhatsApp Web requires persistent browser sessions which are tricky in Docker. **Recommended approach**:

1. **Keep WhatsApp on Local Mac** (easiest)
   - Run local gateway just for WhatsApp
   - Use Render for API/web access only

2. **Use Baileys (WhatsApp API)** (advanced)
   - Requires code changes to use Baileys library
   - Stores session in persistent disk
   - More complex but works in containers

---

## Testing Both Environments

**Local:**
```bash
# Send test message via CLI
openclaw agent --agent main --message "Hello local!" --deliver

# Or via WhatsApp
# Text your number: "Hi"
```

**Render:**
```bash
# Via HTTP API (once deployed)
curl https://YOUR-SERVICE.onrender.com/api/agent \
  -H "Authorization: Bearer YOUR-GATEWAY-TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello from cloud!"}'
```

---

## Troubleshooting

### Local: WhatsApp Not Connecting
```bash
# Check QR code in logs
openclaw logs | grep -A 20 "QR"

# Or restart gateway
openclaw gateway --force
```

### Render: Service Won't Start
Check Render Dashboard → Logs for errors. Common issues:
- **Missing env vars**: Verify `OLLAMA_BASE_URL` is set
- **Ngrok expired**: Update to new ngrok URL and redeploy
- **Port mismatch**: Must be `8080`

### Render: Can't Access Setup Wizard
If `/setup` returns 404:
- Check logs for gateway startup errors
- Verify service is running (not in restart loop)
- Try `/health` endpoint first

---

## Files Reference

**Local Config:**
- [`~/.openclaw/openclaw.json`](file:///Users/richardsongunde/.openclaw/openclaw.json) - Main configuration

**Render Config:**
- [`render.yaml`](file:///Users/richardsongunde/projects/openclaw/render.yaml) - Deployment blueprint
- [`Dockerfile`](file:///Users/richardsongunde/projects/openclaw/Dockerfile) - Container image

**Testing:**
- [`docker-compose.render.yml`](file:///Users/richardsongunde/projects/openclaw/docker-compose.render.yml) - Local Render simulation

---

## Next Steps

1. ✅ Local gateway running
2. ⏳ Deploy to Render
3. ⏳ Configure remote Ollama URL
4. ⏳ Test both environments

**Ready to deploy?** Follow the "Deploy to Render" steps above!
