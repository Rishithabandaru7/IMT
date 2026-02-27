#!/bin/bash

# Exit immediately if a command fails
set -e

# Variables
DOCKER_USER="bandarurishitha"
IMAGE_NAME="incident_app"
FLASK_CONTAINER="incident_app_container"
MYSQL_CONTAINER="mysql_container"
MYSQL_ROOT_PASS="root@123"
MYSQL_DB="incident_db"

# -------------------------------
# 1️⃣ Clean up existing MySQL container (if exists)
# -------------------------------
if [ "$(docker ps -aq -f name=$MYSQL_CONTAINER)" ]; then
    echo "Removing existing MySQL container..."
    sudo docker rm -f $MYSQL_CONTAINER
fi

# -------------------------------
# 2️⃣ Start MySQL
# -------------------------------
echo "Starting MySQL container..."
sudo docker run -d \
    --name $MYSQL_CONTAINER \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASS \
    -e MYSQL_DATABASE=$MYSQL_DB \
    -p 3308:3306 \
    mysql:8

# Wait for MySQL to be ready
echo "Waiting for MySQL to initialize..."
until sudo docker exec $MYSQL_CONTAINER mysql -uroot -p$MYSQL_ROOT_PASS -e "SELECT 1;" &> /dev/null; do
    sleep 2
done
echo "MySQL is ready!"

# -------------------------------
# 3️⃣ Stop old Flask container
# -------------------------------
if [ "$(docker ps -q -f name=$FLASK_CONTAINER)" ]; then
    echo "Stopping existing Flask container..."
    sudo docker stop $FLASK_CONTAINER
fi

if [ "$(docker ps -aq -f name=$FLASK_CONTAINER)" ]; then
    echo "Removing existing Flask container..."
    sudo docker rm $FLASK_CONTAINER
fi

# -------------------------------
# 4️⃣ Pull latest Flask image
# -------------------------------
echo "Pulling latest Flask image from DockerHub..."
sudo docker pull $DOCKER_USER/$IMAGE_NAME:latest

# -------------------------------
# 5️⃣ Start Flask container
# -------------------------------
echo "Starting Flask container..."
sudo docker run -d \
    --name $FLASK_CONTAINER \
    -p 5000:5000 \
    --link $MYSQL_CONTAINER:mysql \
    -e DB_HOST=mysql \
    -e DB_USER=root \
    -e DB_PASSWORD=$MYSQL_ROOT_PASS \
    -e DB_NAME=$MYSQL_DB \
    $DOCKER_USER/$IMAGE_NAME:latest

echo "Deployment complete!"