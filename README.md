### Nine Chronicles | Development Tool
# nodeManager

This project provides a quick auto-updatable solution for a Nine Chronicles node, for development purposes.

<br>

### Features:
- Auto-updates based on this URL: https://download.nine-chronicles.com/apv.json
- Auto downloads snapshot
- Generates new docker container as a node
- Demo Account
    - I have created and provided a demo account for development purposes only. Please do not change the password but you are welcome to change other things for your testing purposes. 
    You can of course use a different account by changing the PrivateKey in the settings.conf file.

<br>

## Usage
***Method 1: Instant Deploy via CMD***

```bash
# Example using default settings & demo account
docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" \
--name nodeManager cryptokasm/9c-nodemanager:latest

# Example using custom settings or personal account
docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" \
--name nodeManager cryptokasm/9c-nodemanager:latest \
--privatekey=000000000000 \
--graphql-port=1212 \
--peer-port=3434
```

<br>

***Method 2: Instant Deploy via docker-compose.yml***

```yml
# Example using default settings & demo account
services:
  nodeManager:
    image: cryptokaksm/9c-nodemanager
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    

# Example using custom settings or personal account
services:
  nodeManager:
    image: cryptokaksm/9c-nodemanager
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: [
      '--privatekey=000000000000',
      '--graphql-port=1212',
      '--peer-port=3434'
    ]
    
```

<br>

***Method 3: Build Image & Deploy***

```bash
COMING SOON

```

<br>

## References
COMING SOON

<br>

# Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

<br>

# Community & Support
Come join us in the community Discord server! If you have any questions, don't hesitate to ask!<br/>
- **Planetarium - [Discord](https://discord.gg/k6z2GS4yh2)**

Support & Bug Reports<br/>
- **CrytpoKasm - [Discord](https://discord.gg/k6z2GS4yh2)**

<br>

# License
[GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/)
