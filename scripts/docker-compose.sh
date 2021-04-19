#!/bin/bash

# Generate docker-compose.yml
buildComposeFile() {
    COMPOSEFILE=docker-compose.yml

    cat <<EOF >$COMPOSEFILE
version: "2.4"

services:
  node:
    image: $DOCKERIMAGE
    container_name: node
    mem_limit: $RAM_LIMIT
    mem_reservation: $RAM_RESERVE
    ports:
      - "$PEER_PORT:31234"
      - "$GRAPHQL_PORT:23061"
    volumes:
      - snapshot:/app/data
      - ./vault/keystore:/app/planetarium/keystore
      - ./vault/secret:/secret
    logging:
      driver: "json-file"
      options:
        "max-size": "20m"
        "max-file": "1"
    command: ['-V=$APV',
      '-G=https://9c-test.s3.ap-northeast-2.amazonaws.com/genesis-block-9c-main',
      '--no-miner',
      '-D=5000000',
      '--store-type=monorocksdb',
      '--store-path=/app/data',
      '--peer=027bd36895d68681290e570692ad3736750ceaab37be402442ffb203967f98f7b6,9c-main-seed-1.planetarium.dev,31234',
      '--peer=02f164e3139e53eef2c17e52d99d343b8cbdb09eeed88af46c352b1c8be6329d71,9c-main-seed-2.planetarium.dev,31234',
      '--peer=0247e289aa332260b99dfd50e578f779df9e6702d67e50848bb68f3e0737d9b9a5,9c-main-seed-3.planetarium.dev,31234',
      '--trusted-app-protocol-version-signer=03eeedcd574708681afb3f02fb2aef7c643583089267d17af35e978ecaf2a1184e',
      '--workers=500',
      '--confirmations=2',
      '--libplanet-node',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us2.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us3.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us4.planetarium.dev:3478',
      '--ice-server=turn://0ed3e48007413e7c2e638f13ddd75ad272c6c507e081bd76a75e4b7adc86c9af:0apejou+ycZFfwtREeXFKdfLj2gCclKzz5ZJ49Cmy6I=@turn-us5.planetarium.dev:3478',
      '--no-cors',
      '--graphql-server',
      '--graphql-port=23061',
      '--graphql-secret-token-path=/secret/token',
      "--miner-private-key=$PRIVATE_KEY"]
volumes:
  snapshot:
EOF
  debug "Created new file"
}

###############################
mainDockerCompose() {
    title "Generating docker-compose.yml.."
    if [ -f "docker-compose.yml" ]; then
        debug "Found existing file"
        rm -f docker-compose.yml
        debug "Deleted existing file"
        buildComposeFile
    else
        buildComposeFile
    fi
    echo
}
###############################