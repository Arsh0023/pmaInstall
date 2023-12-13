#!/bin/bash

# Install Docker
yum install -y docker

# Check architecture
ARCHITECTURE=$(uname -m)

if [ "$ARCHITECTURE" = "aarch64" ]; then
    # Installing Compose for ARM architecture
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins
    curl -SL https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-linux-aarch64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
    service docker start

    # Get Pma
    wget https://git.clicklabs.in/docker/Pma-docker/repository/master/archive.zip
    unzip archive.zip
    cd $(ls | grep 'Pma-docker-master')
    mv pma_graviton.yaml docker-compose.yml
    docker compose up -d

    if [ $? -eq 0 ]; then
        docker-compose up -d
    fi
fi

if [ "$ARCHITECTURE" = "x86_64" ]; then
    # Installing Compose for x86_64 architecture
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins
    curl -SL https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
    service docker start

    # Get Pma
    wget https://git.clicklabs.in/docker/Pma-docker/repository/master/archive.zip
    unzip archive.zip
    cd $(ls | grep 'Pma-docker-master')
    mv pma.yml docker-compose.yml
    docker compose up -d

    if [ $? -eq 0 ]; then
        docker-compose up -d
    fi
fi
