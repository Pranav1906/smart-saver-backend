# 🚀 Railway Deployment Guide for Smart Saver Backend

## Overview
This guide will help you deploy your Smart Saver backend on Railway using both terminal CLI and web dashboard methods.

---

## 📋 Prerequisites
- GitHub account
- Railway account (free tier available)
- Node.js installed locally (for CLI method)

---

## 🛠️ Method 1: Railway CLI (Terminal)

### Step 1: Install Railway CLI
```bash
# Install Railway CLI globally
npm install -g @railway/cli

# Login to Railway
railway login
```

### Step 2: Prepare Your Backend Repository
```bash
# Navigate to your backend directory
cd lib/smart-saver-backend

# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Smart Saver Backend"

# Create a new repository on GitHub (via web interface)
# Then link your local repo to GitHub
git remote add origin https://github.com/YOUR_USERNAME/smart-saver-backend.git
git branch -M main
git push -u origin main
```

### Step 3: Deploy via CLI
```bash
# Navigate to backend directory
cd lib/smart-saver-backend

# Link to Railway project
railway link

# Deploy to Railway
railway up

# Open your deployed app
railway open

# View logs
railway logs

# Check status
railway status
```

### Step 4: Configure Environment Variables (CLI)
```bash
# Set environment variables
railway variables set NODE_ENV=production
railway variables set PORT=3000

# View current variables
railway variables

# Deploy with new variables
railway up
```

---

## 🌐 Method 2: Railway Web Dashboard

### Step 1: Create Railway Account
1. Go to [railway.app](https://railway.app)
2. Click "Start a New Project"
3. Sign up with GitHub (recommended) or email
4. Complete email verification

### Step 2: Create New Project
1. Go to [railway.app/dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"

### Step 3: Connect GitHub Repository
1. **Authorize Railway**: Click "Authorize Railway" to connect your GitHub account
2. **Select Repository**: Choose your `smart-saver-backend` repository
3. **Deploy**: Click "Deploy Now"

### Step 4: Configure Project Settings
1. **Go to Project Dashboard**: Click on your deployed project
2. **Settings Tab**: Click "Settings" in the left sidebar
3. **Environment Variables**: Add if needed:
   ```
   NODE_ENV=production
   PORT=3000
   ```

### Step 5: Get Your Domain
1. **Settings Tab**: Go to "Settings"
2. **Domains**: Copy your generated domain (e.g., `smartapp.up.railway.app`)
3. **Custom Domain** (Optional): Add your own domain if you have one

---

## 🔧 Configuration Files Explained

### railway.json
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "node server.js",
    "healthcheckPath": "/health",
    "healthcheckTimeout": 100,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### nixpacks.toml
```toml
[phases.setup]
nixPkgs = ["python3", "pip", "ffmpeg", "curl"]

[phases.install]
cmds = [
  "pip install --upgrade pip",
  "pip install yt-dlp",
  "python3 -m pip install --upgrade yt-dlp"
]

[phases.build]
cmds = ["npm install"]

[start]
cmd = "node server.js"
```

### Procfile
```
web: node server.js
```

---

## 🧪 Testing Your Deployment

### Test Health Check
```bash
# Using curl
curl https://your-app-name.up.railway.app/health

# Expected response:
{
  "status": "healthy",
  "message": "Video Downloader Backend is running!",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "uptime": 123.456,
  "ytDlpInstalled": true,
  "supportedPlatforms": ["YouTube", "Instagram"]
}
```

### Test API Endpoints
```bash
# Test root endpoint
curl https://your-app-name.up.railway.app/

# Test video info endpoint
curl -X POST https://your-app-name.up.railway.app/video/info \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"}'
```

---

## 📱 Update Flutter App

### Update API URLs
Replace the URLs in your Flutter app:

```dart
// In reels_tab.dart
Uri.parse('https://your-app-name.up.railway.app/download/instagram')

// In shorts_tab.dart  
Uri.parse('https://your-app-name.up.railway.app/download/youtube')
```

### Test Connection
```bash
# Test from your local machine
curl https://your-app-name.up.railway.app/health
```

---

## 📊 Monitoring and Management

### CLI Commands
```bash
# View logs
railway logs

# View logs with follow
railway logs --follow

# Check status
railway status

# Restart service
railway service restart

# Open in browser
railway open

# View variables
railway variables

# Set variable
railway variables set KEY=VALUE
```

### Web Dashboard Features
1. **Deployments**: View deployment history and logs
2. **Metrics**: Monitor CPU, memory, and network usage
3. **Logs**: Real-time log viewing
4. **Variables**: Manage environment variables
5. **Domains**: Configure custom domains
6. **Settings**: Project configuration

---

## 🚨 Troubleshooting

### Common Issues

**Issue: Build fails**
```bash
# Check build logs in Railway dashboard
# Common causes:
# - Missing dependencies in package.json
# - Python/yt-dlp installation issues
# - Node.js version incompatibility
```

**Issue: yt-dlp not found**
```bash
# Check if yt-dlp is installed in build logs
# Verify nixpacks.toml configuration
# Wait for build to complete (can take 5-10 minutes)
```

**Issue: Port binding errors**
```bash
# Railway automatically sets PORT environment variable
# Your server.js already handles this correctly
# Check if PORT is being used correctly
```

**Issue: CORS errors**
```bash
# Your server already has CORS configured
# Check if frontend is using correct domain
# Verify HTTPS vs HTTP
```

### Debug Commands
```bash
# Check Railway status
railway status

# View detailed logs
railway logs --follow

# Check environment variables
railway variables

# Restart service
railway service restart
```

---

## 🔄 Continuous Deployment

### Auto-Deploy Setup
1. **GitHub Integration**: Railway automatically deploys when you push to GitHub
2. **Branch Protection**: Set up branch protection rules for production
3. **Environment Variables**: Configure different variables for different environments

### Manual Deployment
```bash
# Deploy manually
railway up

# Deploy specific branch
railway up --branch develop
```

---

## 💰 Railway Pricing

### Free Tier
- **500 hours/month** of runtime
- **512MB RAM** per service
- **1GB storage**
- **100GB bandwidth**
- **Unlimited deployments**

### Pro Plan ($5/month)
- **Unlimited hours**
- **2GB RAM** per service
- **10GB storage**
- **Unlimited bandwidth**
- **Priority support**

---

## ✅ Deployment Checklist

### CLI Method
- [ ] Railway CLI installed and logged in
- [ ] Backend code in separate GitHub repository
- [ ] All configuration files present
- [ ] `railway link` executed
- [ ] `railway up` deployed successfully
- [ ] Health check endpoint working
- [ ] API endpoints responding correctly
- [ ] Flutter app updated with Railway domain

### Web Dashboard Method
- [ ] Railway account created
- [ ] GitHub repository connected
- [ ] Project deployed successfully
- [ ] Environment variables configured
- [ ] Domain copied and noted
- [ ] Health check endpoint working
- [ ] API endpoints responding correctly
- [ ] Flutter app updated with Railway domain

---

## 🎉 Success!

Your Smart Saver backend is now running on Railway!

**Your API endpoints:**
- Health: `https://your-app-name.up.railway.app/health`
- Instagram: `https://your-app-name.up.railway.app/download/instagram`
- YouTube: `https://your-app-name.up.railway.app/download/youtube`

**Estimated monthly cost:** $0 (within free tier limits)

---

## 📞 Support

- **Railway Documentation**: [docs.railway.app](https://docs.railway.app)
- **Railway Discord**: [discord.gg/railway](https://discord.gg/railway)
- **GitHub Issues**: Create issues in your repository for code-specific problems 