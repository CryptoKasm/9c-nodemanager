#!/bin/bash
source ./scripts/lib.sh
source ./scripts/docker-compose.sh
source ./scripts/snapshot.sh
source ./VERSION

# Clean up generated files
function clean() {
    sudo rm -f docker-compose.yml
    sudo rm -rf latest-snapshot
    sudo rm -f 9c-main-snapshot.zip
    sudo rm -rf logs
    sudo rm -rf vault
}

# Start docker container in detached mode
function startDocker() {
    debug "Starting docker..."
    docker-compose up -d
}

# Build docker image using data from VERSION file
function buildDockerImage() {
    clean

    imageName="$Repository:$Version"
    dockerFile=".devcontainer/Dockerfile-Prod"

    docker build -f $dockerFile -t $imageName .

    debug "ImageName: $imageName"
    debug "DockerFile: $dockerFile"
}

# Run docker image with parameters
function runDockerImage() {
    imageName="$Repository:$Version"
    docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" --name nodeManager $imageName
}

###############################
function mainNode() {
    checkRoot
    checkSettings
    checkParams
    mainDockerCompose
    mainSnapshot
    startDocker
}
###############################
case $1 in
  --clean)
    clean
    exit 0
    ;;

  --force)
    forceRefresh
    exit 0
    ;;

  --volume)
    testVol
    exit 0
    ;;

  --running)
    testDockerRunning
    exit 0
    ;;

  --build)
    buildDockerImage
    exit 0
    ;;
    
  --run)
    runDockerImage 
    exit 0
    ;;

  *)
    mainNode
    exit 0
    ;;

esac