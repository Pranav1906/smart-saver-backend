#!/bin/bash

# Smart Saver Backend - Quick Railway Deployment Script
# This script automates the Railway deployment process

echo "🚀 Smart Saver Backend - Railway Deployment"
echo "=========================================="

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Installing..."
    npm install -g @railway/cli
else
    echo "✅ Railway CLI found"
fi

# Check if user is logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 Please login to Railway..."
    railway login
else
    echo "✅ Already logged in to Railway"
fi

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -f "server.js" ]; then
    echo "❌ Please run this script from the backend directory (lib/smart-saver-backend)"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📁 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Smart Saver Backend"
    echo "⚠️  Please create a GitHub repository and push your code:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/smart-saver-backend.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo ""
    echo "After pushing to GitHub, run this script again."
    exit 1
fi

# Check if Railway project is linked
if [ ! -f ".railway" ]; then
    echo "🔗 Linking to Railway project..."
    railway link
fi

# Deploy to Railway
echo "🚀 Deploying to Railway..."
railway up

# Get the deployment URL
echo "📋 Getting deployment URL..."
railway domain

echo ""
echo "✅ Deployment complete!"
echo "📊 Check status: railway status"
echo "📝 View logs: railway logs"
echo "🌐 Open in browser: railway open"
echo ""
echo "🔗 Your API endpoints:"
echo "   Health: https://$(railway domain)/health"
echo "   Instagram: https://$(railway domain)/download/instagram"
echo "   YouTube: https://$(railway domain)/download/youtube" 