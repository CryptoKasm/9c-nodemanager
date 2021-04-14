#!/bin/bash

# Library of helper functions
# checkRoot
# checkParams
# checkSettings

####################################################

# Show debug output
function debug() {
    M="\e[35m"
    R="\e[0m"   
    if [ "$DEBUG" == 1 ]; then 
        echo -e $M"> $1"$R
    fi
}

# Check if user is root and grant permission if not
function checkRoot() { 
    if [ "$EUID" -ne 0 ]; then
        sudo echo -ne "\r"
    fi
}

# Check if "settings.conf" exists: read file or create file
function checkSettings() {
    if [ -f "settings.conf" ]; then
        source settings.conf
        debug "Settings.conf found"
        debug "Debug: $DEBUG"
        debug "Private Key: $PRIVATE_KEY"
        debug "RAM Limit: $RAM_LIMIT"
        debug "RAM Reserve: $RAM_RESERVE"
        debug "Refresh Snapshot: $REFRESH_SNAPSHOT"
        debug "Cronjob Auto Restart: $CRONJOB_AUTO_RESTART"
        debug "GraphQL Queries: $GRAPHQL_QUERIES"
    else
        debug "settings.conf not found"
    fi
}

# Check parameters from https://download.nine-chronicles.com/apv.json
function checkParams() {
    BUILDPARAMS="https://download.nine-chronicles.com/apv.json"
    APV=`curl --silent $BUILDPARAMS | jq -r '.apv'`
    DOCKERIMAGE=`curl --silent $BUILDPARAMS | jq -r '.docker'`
    SNAPSHOT=`curl --silent $BUILDPARAMS | jq -r '."snapshotPaths:"[0]'`

    debug "URL: $BUILDPARAMS"
    debug "APV: $APV"
    debug "DockerImage: $DOCKERIMAGE"
    debug "SnapshotURL: $SNAPSHOT"
}