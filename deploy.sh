#!/bin/bash

# GitHub Repository Setup and Deployment to Render
# Run this script after creating your GitHub repository

set -e  # Exit on error

echo "🚀 OpenClaw Render Deployment Script"
echo "======================================="
echo ""

# Get GitHub username and repo name
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name [openclaw-render]: " REPO_NAME
REPO_NAME=${REPO_NAME:-openclaw-render}

# Get ngrok URL
echo ""
echo "Current ngrok URL: https://85a10ae4dca6.ngrok-free.app"
read -p "Enter your ngrok URL (or press Enter to use current): " NGROK_URL
NGROK_URL=${NGROK_URL:-https://85a10ae4dca6.ngrok-free.app}

echo ""
echo "📝 Configuration:"
echo "  GitHub: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "  Ngrok: $NGROK_URL"
echo ""

# Confirm
read -p "Press Enter to continue or Ctrl+C to cancel..."

# Add remote
echo "🔗 Adding GitHub remote..."
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Create main branch if needed
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🌿 Creating main branch..."
    git branch -M main
fi

# Push to GitHub
echo "⬆️  Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Successfully pushed to GitHub!"
echo ""
echo "📦 Repository: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""
echo "🎯 Next Steps:"
echo ""
echo "1. Go to: https://render.com/deploy?repo=https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "   (Or click 'Deploy' button in your GitHub README)"
echo ""
echo "2. Set environment variables in Render:"
echo "   - SETUP_PASSWORD: your-secure-password"
echo "   - OLLAMA_BASE_URL: $NGROK_URL/v1"
echo ""
echo "3. Click 'Apply' to deploy"
echo ""
echo "4. Access your app at: https://YOUR-SERVICE-NAME.onrender.com"
echo ""
echo "5. Complete setup wizard at: https://YOUR-SERVICE-NAME.onrender.com/setup"
echo ""

# Create deployment badge
echo "📌 Add this badge to your README:"
echo ""
echo "[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/$GITHUB_USERNAME/$REPO_NAME)"
echo ""
