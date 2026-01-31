# Quick Start: Deploy to Render

Follow these steps to deploy OpenClaw to Render with your remote Ollama server.

## 1. Update Your Ngrok URL

Edit this file and replace with your current ngrok URL:
```bash
# In render.yaml, add custom env vars (after line 17):
- key: OLLAMA_BASE_URL
  value: "https://YOUR-NGROK-URL.ngrok.io/v1"
```

## 2. Push to GitHub

```bash
cd /Users/richardsongunde/projects/openclaw
git init
git add .
git commit -m "OpenClaw for Render"
git remote add origin https://github.com/YOUR-USERNAME/openclaw-render.git
git push -u origin main
```

## 3. Deploy to Render

**Option A: One-Click Deploy (Easiest)**

Click this button (after pushing to GitHub):
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

**Option B: Manual Deploy**

1. Go to https://render.com/dashboard
2. New + → Blueprint
3. Connect your repo
4. Set environment variables:
   - `SETUP_PASSWORD`: your-password
   - `OLLAMA_BASE_URL`: https://your-ngrok.url/v1
5. Deploy!

## 4. Configure

Visit `https://your-service.onrender.com/setup` and:
- Enter SETUP_PASSWORD
- Select "Custom OpenAI API"
- Base URL: your ngrok URL
- Model: `qwen3-vl:4b`

## 5. Test

```bash
curl https://your-service.onrender.com/health
```

---

**Full guide**: See [`DEPLOYMENT.md`](./DEPLOYMENT.md)
