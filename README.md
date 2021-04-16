### Nine Chronicles | Development Tool
# Project: nodeManager

This project provides a quick auto-updatable solution for a Nine Chronicles node, for development purposes.

Features:
- Auto-updates based on this URL: https://download.nine-chronicles.com/apv.json
- Auto downloads snapshot
- Generates new docker container as a node
- Demo Account
    - I have created and provided a demo account for development purposes only. Please do not change the password but you are welcome to change other things for your testing purposes. 
    You can of course use a different account by changing the PrivateKey in the settings.conf file.

<br>

## Usage
***Method 1: Instant Deploy (using Demo Account)***

```bash
# Example: docker run 
docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" --name nodeManager cryptokasm/nodemanager:latest

# Example: docker-compose.yml

```
***Method 2: Build Image & Deploy***

```bash
# Example: docker run 
docker run -d -v "/var/run/docker.sock:/var/run/docker.sock" --name nodeManager cryptokasm/nodemanager:latest

# Example: docker-compose.yml

```

<br>

## References
- https://docs.microsoft.com/en-us/windows/wsl/install-win10
- https://docs.docker.com/docker-for-windows/install-windows-home/

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
