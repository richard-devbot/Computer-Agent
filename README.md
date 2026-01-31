# OpenClaw Render Deployment

This is a customized OpenClaw deployment configured for:
- **Render.com** hosting with remote Ollama via ngrok
- **Local development** with WhatsApp integration
- **Dual environment** support (local + cloud)

## Quick Deploy to Render

See [`RENDER_DEPLOY.md`](./RENDER_DEPLOY.md) for 5-step deployment guide.

## Features

✅ Docker-ready for Render deployment  
✅ Remote Ollama support via ngrok  
✅ Local WhatsApp integration  
✅ Environment variable configuration  
✅ Persistent storage support  

## Files

- `render.yaml` - Render Blueprint for one-click deploy
- `Dockerfile` - Container image
- `DEPLOYMENT.md` - Comprehensive deployment guide
- `RENDER_DEPLOY.md` - Quick start guide

## Local Setup

```bash
# Install OpenClaw
npm install -g openclaw

# Start gateway
openclaw gateway

# Check status
openclaw status
```

See [`DEPLOYMENT.md`](./DEPLOYMENT.md) for full documentation.

## Environment Variables (Render)

| Variable | Description |
|----------|-------------|
| `OLLAMA_BASE_URL` | Your ngrok Ollama URL |
| `SETUP_PASSWORD` | Password for /setup wizard |
| `PORT` | 8080 (required by Render) |

## License

MIT (original OpenClaw project)

---

**Based on**: [openclaw/openclaw](https://github.com/openclaw/openclaw)
