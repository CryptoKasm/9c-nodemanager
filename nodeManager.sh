#!/bin/bash
source ./scripts/lib.sh
source ./scripts/docker-compose.sh
source ./scripts/snapshot.sh
source ./scripts/runtime.sh
source ./VERSION

# Clean up generated files
function clean() {
    sudo rm -f docker-compose.yml
    sudo rm -rf latest-snapshot
    sudo rm -f 9c-main-snapshot.zip
    sudo rm -rf logs
    sudo rm -rf vault
}

# Clean up generated files
function cleanAll() {
    sudo rm -f docker-compose.yml
    sudo rm -rf latest-snapshot
    sudo rm -f 9c-main-snapshot.zip
    sudo rm -rf logs
    sudo rm -rf vault
    docker-compose down -v --remove-orphans
}

# Start docker container in detached mode
function startDocker() {
    title "Starting docker..."
    docker-compose up -d
    title "Complete! Stopping docker image..."
}

# Build docker image using data from VERSION file
function buildDockerImage() {
    clean

    imageName="$repository:$version"
    dockerFile="./Dockerfile"

    docker build -f $dockerFile -t $imageName .

    debug "ImageName: $imageName"
    debug "DockerFile: $dockerFile"
}

# Run docker image with parameters
function runDockerImage() {
    imageName="$repository:$version"
    docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" --name nodeManager $imageName
}

# Demo information
function startDemo() {
    if [ "$DEMO" == 1 ]; then
        debug "USING DEMO ACCOUNT"$RS
        echo
    else
      debug "USING ARGUMENTS"
      echo
    fi
}

###############################
function mainNode() {
    intro
    startDemo
    checkRoot
    checkSettings
    checkParams
    checkRuntime
    mainDockerCompose
    mainSnapshot
    startDocker
}
###############################
for i in "$@"
do
case $i in

  --private-key=*)
    SET_PRIVATE_KEY="${i#*=}"
    debug "User set privatekey: $SET_PRIVATE_KEY"
    ;;
  
  --graphql-port=*)
    SET_GRAPHQL_PORT="${i#*=}"
    debug "User set graphql-port: $SET_GRAPHQL_PORT"
    ;;

  --peer-port=*)
    SET_PEER_PORT="${i#*=}"
    debug "User set peer-port: $SET_PEER_PORT"
    ;;

  --cors-policy=*)
    SET_CORS_POLICY="${i#*=}"
    debug "User set cors-policy: $SET_CORS_POLICY"
    ;;

  --clean)
    clean
    exit 0
    ;;

  --clean-all)
    cleanAll
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
    
  --demo)
    DEMO=1
    ;;

  *)
    error "Argument is invalid. Please check correct syntax."
    exit 0
    ;;

esac
done

mainNode
exit 0