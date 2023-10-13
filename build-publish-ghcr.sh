#!/bin/bash

# Variáveis de configuração
DOCKER_USERNAME="alexssantos"
DOCKER_REPO="comparador-metodo-pgto"
DOCKER_IMG="alexssantos/comparador-metodo-pgto"
TAG_TALEST="latest"
TAG_ID=$(date +%Y%m%d_%H%M%S)
#DOCKERFILE="Dockerfile"  # Nome do seu arquivo Dockerfile
#APP_NAME="sua_aplicacao"
#SOLUTION_FILE="sua_solucao.sln"  # Nome do arquivo de solução .NET
#PROJECT_FOLDER="./para/seu_projeto"  # Caminho para o projeto .NET
CONTEXT="./ComparadorMetodoPgto"  # Diretório de contexto
REGISTRY="ghcr.io"
#CR_PAT = Github Personal Access Token. Env definido na maquina local.
REGISTRY_URL="ghcr.io/alexssantos/comparador-metodo-pgto"


# Etapa 1: Build da aplicação .NET
# echo "Passo 1: Build da aplicação .NET"
# dotnet publish -c Release $PROJECT_FOLDER/$SOLUTION_FILE

# Etapa 1: Build da imagem Docker
echo "===================================="
echo "Passo 1/4: Build da imagem Docker"
echo "===================================="
docker build -t $DOCKER_IMG:$TAG_ID -t $DOCKER_IMG:$TAG_TALEST $CONTEXT

# Etapa 2: Login no Docker Hub
#**GitHub Packages only supports authentication using a personal access token (classic).
echo "===================================="
echo "Passo 2/4: Login no Github-CR"
echo "===================================="
echo $CR_PAT | docker login $REGISTRY -u $DOCKER_USERNAME --password-stdin

# Etapa 3: Tag image docker
echo "===================================="
echo "Passo 3/4: Tag image"
echo "===================================="
docker tag $DOCKER_IMG:$TAG_TALEST $REGISTRY_URL:$TAG_ID

# Etapa 4: Publicação da imagem no Github CR
echo "==============================================="
echo "Passo 4/4: Publicação da imagem no Github-CR"
echo "==============================================="
## $docker push <REGISTRY_HOST>:<REGISTRY_PORT>/<APPNAME>:<APPVERSION>
docker push $REGISTRY_URL:$TAG_ID

# Etapa 5: Limpeza (opcional)
# Remova a imagem local se desejar economizar espaço após o push
# echo "Passo 5: Limpeza"
# docker rmi $DOCKER_USERNAME/$DOCKER_REPO:$DOCKER_TAG

# FINISHED
echo "==============================================="
echo "Build e publicação concluídos com sucesso."
echo "==============================================="