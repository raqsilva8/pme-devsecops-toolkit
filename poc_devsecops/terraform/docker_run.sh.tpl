#!/bin/bash
set -e

apt-get update -y
apt-get install -y docker.io
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

systemctl start docker
systemctl enable docker

az login --identity

ACR_NAME="pocregistryisep"
ACR_LOGIN_SERVER="pocregistryisep.azurecr.io"
IMAGE_NAME="myproject"
KEY_VAULT_NAME="pockeyvaultisep"
PUBLIC_IP="${public_ip}"

# Debug output
set -x
echo "ACR_NAME: $ACR_NAME"
echo "ACR_LOGIN_SERVER: $ACR_LOGIN_SERVER"
echo "IMAGE_NAME: $IMAGE_NAME"
echo "KEY_VAULT_NAME: $KEY_VAULT_NAME"
echo "PUBLIC_IP: $PUBLIC_IP"

# Login to Azure Container Registry
sudo az acr login --name $ACR_NAME

# Get the latest image tag (or use 'latest')
IMAGE_TAG="latest"

# Pull the Docker image from ACR
if ! sudo docker pull $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG; then
  echo "Failed to pull image $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG"
  exit 1
fi

# Fetch Django secret key from Azure Key Vault
DJANGO_SECRET_KEY=$(az keyvault secret show --vault-name $KEY_VAULT_NAME --name django-secret-key --query value -o tsv)

# Run the Docker container with the secret key and allowed hosts as env vars
if ! sudo docker run -d -p 80:8000 \
  -e SECRET_KEY="$DJANGO_SECRET_KEY" \
  -e ALLOWED_HOSTS="$PUBLIC_IP" \
  $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG; then
  echo "Failed to start Docker container."
  exit 1
fi

