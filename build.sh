#!/bin/bash
# build.sh - Builds Docker images for all containers

echo "🔧 Building Docker images..."
sudo docker-compose build
echo "✅ Build complete."
