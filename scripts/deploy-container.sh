#!/bin/bash

IMAGE_NAME="miguelrodr1gues/user-service:1.0"
CONTAINER_NAME="user-service"
HOST_PORT=8080       # Porta da EC2 que você acessa do seu PC
CONTAINER_PORT=8081  # Porta interna do container

echo "Deploying container..."

# Stop and remove existing container
docker stop $CONTAINER_NAME 2>/dev/null
docker rm $CONTAINER_NAME 2>/dev/null

# Pull latest image
docker pull $IMAGE_NAME

# Run container com mapeamento correto de portas
docker run -d \
 --name $CONTAINER_NAME \
 -p $HOST_PORT:$CONTAINER_PORT \
 --restart unless-stopped \
 $IMAGE_NAME

# Wait for container to start
sleep 5

# Check if container is running
if docker ps | grep -q $CONTAINER_NAME; then
  echo "Container deployed successfully"
  docker logs --tail 20 $CONTAINER_NAME
else
  echo "Container failed to start"
  docker logs $CONTAINER_NAME
  exit 1
fi