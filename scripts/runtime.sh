#!/bin/bash

# Set PrivateKey if argument provided
function setPrivateKey() {
    debug "PrivateKey (from settings.conf): $PRIVATE_KEY"
    if [ -n "$SET_PRIVATE_KEY" ]; then
        debug "Entered PrivateKey: $SET_PRIVATE_KEY"
        PRIVATE_KEY=$SET_PRIVATE_KEY
        debug "New PrivateKey: $PRIVATE_KEY"
    else
        debug "SET_PRIVATE_KEY is empty."
    fi
}

# Set GraphQL Port if argument provided
function setGraphqlPort() {
    debug "GraphQL Port (from settings.conf): $GRAPHQL_PORT"
    if [ -n "$SET_GRAPHQL_PORT" ]; then
        debug "Entered GraphQL Port: $SET_GRAPHQL_PORT"
        GRAPHQL_PORT=$SET_GRAPHQL_PORT
        debug "New GraphQL Port: $GRAPHQL_PORT"
    else
        debug "SET_GRAPHQL_PORT is empty."
    fi
}

# Set Peer Port if argument provided
function setPeerPort() {
    debug "Peer Port (from settings.conf): $PEER_PORT"
    if [ -n "$SET_PEER_PORT" ]; then
        debug "Entered Peer Port: $SET_PEER_PORT"
        PEER_PORT=$SET_PEER_PORT
        debug "New Peer Port: $PEER_PORT"
    else
        debug "SET_PEER_PORT is empty."
    fi
}

# Check arguments at runtime to set variables
function checkRuntime () {
    title "Checking runtime arguments..."
    setPrivateKey
    setGraphqlPort
    setPeerPort
    echo
}