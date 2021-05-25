#!/bin/bash
source ./VERSION

# > Library of helper functions
# debug
# error
# checkRoot
# checkParams
# checkSettings
####################################################
# Variables
Yellow="\e[33m"
Cyan="\e[36m"
Magenta="\e[35m"
Green="\e[92m"
Red="\e[31m"
RS="\e[0m"
RSL="\e[1A\e["
RSL2="\e[2A\e["
RSL3="\e[3A\e["
sB="\e[1m"

# Introduction
function intro() {
    echo -e $Cyan">> Nine Chronicles | Development Tool"
    echo -e ">> Project: $project"
    echo -e ">> Maintainer: $maintainer"
    echo -e ">> Docker Repository: $dockerRepo"
    echo -e ">> Version: $version"
    echo -e ">> Github: $github"
    echo -e ">> Discord/Support: $discord"
    echo
}

# Display styled text for errors
function title() {  
        echo -e $Cyan"> $1"$RS
}

# Display styled text for debugging
function debug() {  
    if [ "$DEBUG" == true ]; then 
        echo -e $Magenta"  - Debug: $1"$RS
    fi
}

# Display styled text for errors
function error() {  
        echo -e $Red"> Error: $1"$RS
}

# Display styled text for success
function warning() {  
        echo -e $Green"> Success: $1"$RS
}

# Display styled text for success
function success() { 
        echo -e $Green"> Success: $1"$RS
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
        title "Loading settings.conf..."
        debug "Debug: $DEBUG"
        debug "Private Key: $PRIVATE_KEY"
        debug "GraphQL Port: $GRAPHQL_PORT"
        debug "CORS Policy: $CORS_POLICY"
        debug "Peer Port: $PEER_PORT"
        debug "RAM Limit: $RAM_LIMIT"
        debug "RAM Reserve: $RAM_RESERVE"
        debug "Refresh Snapshot: $REFRESH_SNAPSHOT"
        debug "GraphQL Queries: $GRAPHQL_QUERIES"
    else
        error "settings.conf not found"
    fi
    echo
}

# Check parameters from https://download.nine-chronicles.com/apv.json
function checkParams() {
    BUILDPARAMS="https://download.nine-chronicles.com/apv.json"
    APV=`curl --silent $BUILDPARAMS | jq -r '.apv'`
    DOCKERIMAGE=`curl --silent $BUILDPARAMS | jq -r '.docker'`
    SNAPSHOT=`curl --silent $BUILDPARAMS | jq -r '."snapshotPaths"[0]'`

    title "Loading apv.json..."
    debug "URL: $BUILDPARAMS"
    debug "APV: $APV"
    debug "DockerImage: $DOCKERIMAGE"
    debug "SnapshotURL: $SNAPSHOT"
    echo
}