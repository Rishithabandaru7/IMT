#!/bin/bash
# Exit immediately if any command fails
set -e

echo "Stopping existing containers..."
sudo docker compose down || true

echo "Pulling latest images..."
sudo docker compose pull

echo "Starting containers..."
sudo docker compose up -d

echo "Deployment successful!"