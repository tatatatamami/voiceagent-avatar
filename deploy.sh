#!/bin/bash

# Azure Container App Deployment Script
set -e

# Configuration - Update these values
RESOURCE_GROUP="rg-ti-eastus2-dev"
CONTAINER_APP_NAME="voice-live-avatar-app"
CONTAINER_REGISTRY_NAME="voiceliveavatarcr"  # ACR name (without .azurecr.io)
IMAGE_NAME="voice-live-avatar"
TAG="latest"
LOCATION="eastus2"
CONTAINER_APP_ENV="voice-live-avatar-env"

CONTAINER_REGISTRY="${CONTAINER_REGISTRY_NAME}.azurecr.io"

echo "🚀 Deploying Voice Live Avatar to Azure Container Apps"

# Login to Azure (if not already logged in)
echo "🔐 Checking Azure login..."
az account show > /dev/null 2>&1 || az login

# Using existing resource group: ${RESOURCE_GROUP}
echo "📁 Using resource group: ${RESOURCE_GROUP}"

# Create ACR if not exists
echo "📦 Creating Container Registry..."
az acr create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CONTAINER_REGISTRY_NAME} \
    --sku Basic \
    --admin-enabled true \
    --output none 2>/dev/null || true

# Login to ACR
echo "🔐 Logging into Container Registry..."
az acr login --name ${CONTAINER_REGISTRY_NAME}

# Build and push Docker image
echo "📦 Building Docker image..."
docker build -t ${CONTAINER_REGISTRY}/${IMAGE_NAME}:${TAG} .

echo "🚢 Pushing to registry..."
docker push ${CONTAINER_REGISTRY}/${IMAGE_NAME}:${TAG}

# Get ACR credentials
ACR_USERNAME=$(az acr credential show --name ${CONTAINER_REGISTRY_NAME} --query "username" -o tsv)
ACR_PASSWORD=$(az acr credential show --name ${CONTAINER_REGISTRY_NAME} --query "passwords[0].value" -o tsv)

# Create Container App Environment if not exists
echo "🌍 Creating Container App Environment..."
az containerapp env create \
    --name ${CONTAINER_APP_ENV} \
    --resource-group ${RESOURCE_GROUP} \
    --location ${LOCATION} \
    --output none 2>/dev/null || true

# Check if Container App exists
APP_EXISTS=$(az containerapp show --name ${CONTAINER_APP_NAME} --resource-group ${RESOURCE_GROUP} --query "name" -o tsv 2>/dev/null || echo "")

if [ -z "$APP_EXISTS" ]; then
    echo "🌐 Creating new Container App..."
    az containerapp create \
        --name ${CONTAINER_APP_NAME} \
        --resource-group ${RESOURCE_GROUP} \
        --environment ${CONTAINER_APP_ENV} \
        --image ${CONTAINER_REGISTRY}/${IMAGE_NAME}:${TAG} \
        --registry-server ${CONTAINER_REGISTRY} \
        --registry-username ${ACR_USERNAME} \
        --registry-password ${ACR_PASSWORD} \
        --target-port 8000 \
        --ingress external \
        --min-replicas 0 \
        --max-replicas 3 \
        --env-vars \
            AZURE_OPENAI_ENDPOINT=secretref:azure-openai-endpoint \
            AZURE_OPENAI_API_KEY=secretref:azure-openai-api-key \
            AZURE_SEARCH_ENDPOINT=secretref:azure-search-endpoint \
            AZURE_SEARCH_KEY=secretref:azure-search-key
else
    echo "🌐 Updating existing Container App..."
    az containerapp update \
        --name ${CONTAINER_APP_NAME} \
        --resource-group ${RESOURCE_GROUP} \
        --image ${CONTAINER_REGISTRY}/${IMAGE_NAME}:${TAG}
fi

# Get the app URL
APP_URL=$(az containerapp show --name ${CONTAINER_APP_NAME} --resource-group ${RESOURCE_GROUP} --query "properties.configuration.ingress.fqdn" -o tsv)

echo ""
echo "✅ Deployment complete!"
echo "🔗 App URL: https://${APP_URL}"
echo ""
echo "⚠️  Don't forget to set environment variables (secrets):"
echo "   az containerapp secret set --name ${CONTAINER_APP_NAME} --resource-group ${RESOURCE_GROUP} \\"
echo "       --secrets azure-openai-endpoint=<YOUR_ENDPOINT> \\"
echo "                 azure-openai-api-key=<YOUR_API_KEY> \\"
echo "                 azure-search-endpoint=<YOUR_SEARCH_ENDPOINT> \\"
echo "                 azure-search-key=<YOUR_SEARCH_KEY>"