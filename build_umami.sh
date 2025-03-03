#!/bin/sh
# Build script for umami with custom base path

# Set your environment variables
source ./.config/.env.docker

# Log in to the Azure container registry
echo "Logging in to Azure Container Registry..."
docker login -u $ACR_USERNAME -p $ACR_PWD $ACR_REGISTRY

# Build the Docker image with build arguments
echo "Building umami Docker image with BASE_PATH=$BASE_PATH..."
docker buildx build \
  --platform linux/amd64 \
  --build-arg DATABASE_TYPE=$DATABASE_TYPE \
  --build-arg BASE_PATH=/ \
  --no-cache \
  --pull \
  --rm \
  -t $ACR_REGISTRY/umami:latest \
  . \
  --push

echo "Build and push completed successfully!"