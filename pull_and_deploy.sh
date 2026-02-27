#!/bin/bash

# Exit immediately if a command fails
set -e

# Variables
DOCKER_USER="bandarurishitha"
IMAGE_NAME="incident_app"
CONTAINER_NAME="incident_app_container"

echo "Stopping any existing container..."
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    sudo docker stop $CONTAINER_NAME
fi

if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    sudo docker rm $CONTAINER_NAME
fi

echo "Pulling latest image from DockerHub..."
sudo docker pull $DOCKER_USER/$IMAGE_NAME:latest

echo "Starting container..."
sudo docker run -d \
    --name $CONTAINER_NAME \
    -p 5000:5000 \
    $DOCKER_USER/$IMAGE_NAME:latest

echo "Deployment complete!"