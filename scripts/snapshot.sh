#!/bin/bash

# Set: Variables
SNAPDIR="latest-snapshot"
SNAPUNZIP="$SNAPDIR/9c-main"
SNAPZIP="9c-main-snapshot.zip"

# Copy: Snapshot to Volumes
copyVolume(){
    debug "Copying snapshot to volume"
    sudo docker cp . node:/app/data/
}

# Refresh: Snapshot
refreshSnapshot() {
    docker-compose down -v    # Stops & deletes environment **snapshot**
    docker-compose up -d        # Restarts to recreate clean environment
    docker-compose stop         # Stops cleaned environment for snapshot update

    debug "SnapDir: $SNAPDIR"
    debug "SnapUnzip: $SNAPUNZIP"
    debug "SnapZip: $SNAPZIP"

    if [ -d $SNAPUNZIP ]; then
        rm -rf latest-snapshot/* 

        if [ -f "$SNAPZIP" ]; then
            rm -f $SNAPZIP
        fi
    else
        mkdir -p latest-snapshot
    fi

    cd latest-snapshot
    curl -# -O $SNAPSHOT
    unzip 9c-main-snapshot.zip &> /dev/null
    sudo chmod -R 700 .
    mv 9c-main-snapshot.zip ../

    copyVolume
}

# Test: Refresh if volume is missing
testVol() {
    debug "Checking volume"
    docker-compose up -d       # Restarts to recreate clean environment
    docker-compose stop


    for OUTPUT in $(docker ps -aqf "name=^node" --no-trunc)
    do
        Dname=$(docker ps -af "id=$OUTPUT" --format {{.Names}})
        VolChecker=$(docker exec 52153fe8fdcd8a4469025e2d3c16ca570442ea26c1214826ae8238c08f23785d [ -d "/app/data/9c-main" ])
        VolCheckerID=$?
        if [[ $VolCheckerID = "1" ]]; then
            debug "$Dname Snapshot Volumes are missing!"
            cd latest-snapshot
            copyVolume
        else
            debug "$Dname Snapshot Volumes are current!"
        fi
        done

        debug $Dname
        debug $VolChecker
        debug $VolCheckerID
}

# Test: Ignore Volume test if docker containers are running
testDockerRunning() {
    if [ ! "$(docker ps -qf "name=^childNode")" ]; then
        testVol
    fi
}

# Test: Refresh if older than 2 hrs
testAge() {
    if [ -d "$SNAPUNZIP" ] && [ -f "$SNAPZIP" ]; then
        debug "Found snapshot"
        sudo chmod -R 700 $SNAPUNZIP
        if [[ $(find "9c-main-snapshot.zip" -type f -mmin +60) ]]; then
            debug "Refreshing snapshot" 
            refreshSnapshot
        else
            debug "Snapshot is current"
            testDockerRunning
        fi
    else
        debug "testAge: False"
        refreshSnapshot
    fi
}

###############################
mainSnapshot() {
    testAge
}
###############################
