#!/bin/bash
source ./scripts/lib.sh

installDocker() {
    sudo apt install docker.io
}

installCompose() {
    # Get: Compose Latest Version
    compose_release() {
        curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")'
    }

    sudo curl -v -L https://github.com/docker/compose/releases/download/$(compose_release)/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

}

###############################
function mainSetup() {
    debug "Installing needed packages..."
    installCompose
}
###############################
mainSetup