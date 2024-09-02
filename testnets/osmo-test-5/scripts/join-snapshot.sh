#!/bin/bash
set -e
RED='\033[0;31m'
GREEN='\033[0;32m'
CLEAN='\033[0m'

INSTALLATION=$1
if [ -z $INSTALLATION ]; then
    INSTALLATION=cosmovisor
fi

MONIKER=$2
if [ -z $MONIKER ]; then
    MONIKER=my-node
fi

OSMOSIS_HOME=$HOME/.osmosisd
OSMOSIS_VERSION=26.0.0-rc3
GOLANG_VERSION=1.21


ADDRBOOK_URL=https://rpc.testnet.osmosis.zone/addrbook


GENESIS_URL=https://genesis.testnet.osmosis.zone/genesis.json
SNAPSHOT_URL=$(curl -s https://osmosis.fra1.digitaloceanspaces.com/osmo-test-5/snapshots/latest)

WAIT=10

# CHECK SYSTEM RESOURCES
if [ "$(nproc)" -lt 4 ]; then
    printf "${RED}CPU cores are less than 4 ${CLEAN}\n"
fi

printf "${GREEN}CPU cores: $(nproc) ${CLEAN}\n"

free_mem=$(free -h | grep -i "^Mem" | awk '{print $2}')
free_mem=${free_mem%.*}
# If the free RAM is less than 8GB, fail
if [ "$free_mem" -lt 7 ]; then
    printf "${RED}Free memory is less than 8GB ${CLEAN}\n"
    printf "${RED}Insufficient RAM, required: 8GB, available: $free_mem ${CLEAN}\n"

fi
printf "Free memory: $free_mem \n"


if uname -m | grep 64 | grep arm >/dev/null; then
    ARCH="arm64"
elif uname -m | grep 64 | grep aarch >/dev/null; then
    ARCH="arm64"
elif uname -m | grep 64 >/dev/null; then
    ARCH="amd64"
elif uname -m | grep arm >/dev/null; then
    ARCH="arm"
elif uname -m | grep 386 >/dev/null; then
    ARCH="386"
else
     printf "${RED}unknown arch: $(uname -m) ${CLEAN}\n"
fi
printf "${GREEN}CPU arch detected: $ARCH \n"

PACKAGES="unzip tar git jq sed wget curl lz4"
GO_PACKAGE_URL="https://go.dev/dl/go$GOLANG_VERSION.linux-$ARCH.tar.gz"
GO_PACKAGE_FILE_NAME=${GO_PACKAGE_URL##*\/}


# CHECK DEPENDENCIES
printf "${GREEN}Verifying dependencies ${CLEAN}\n"

sudo apt update >/dev/null 2>&1 || printf "${RED}Failed to run sudo apt update - please make sure you have sudo privileges ${CLEAN}\n"
for dep in $PACKAGES; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        printf "${GREEN}Installing $dep...${GREEN}"
        sudo apt-get install "$dep" -y >/dev/null 2>&1 || printf "${RED}Failed to install $dependency ${CLEAN}\n"
    fi
done

sudo wget -q https://github.com/TomWright/dasel/releases/download/v1.20.0/dasel_linux_$ARCH -O /usr/local/bin/dasel
sudo chmod +x /usr/local/bin/dasel

if [ "$INSTALLATION" == "docker" ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    printf "${GREEN}Installing docker... ${CLEAN}\n"
    sh get-docker.sh >/dev/null
    rm get-docker.sh
    sudo usermod -aG docker $USER

fi

printf "${GREEN}Dependencies installed... ${CLEAN}\n"

# INSTALL GO

wget -q $GO_PACKAGE_URL

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $GO_PACKAGE_FILE_NAME

echo "export PATH=\$PATH:/usr/local/go/bin" >>~/.profile
echo "export PATH=\$PATH:\$(go env GOPATH)/bin" >>~/.profile
source ~/.profile

printf "${GREEN}Go version installed: $(go version) ${CLEAN}\n"
printf "${GREEN}GOPATH: $(go env GOPATH) ${CLEAN}\n"

rm $GO_PACKAGE_FILE_NAME

printf "${GREEN}Starting node configuration ${CLEAN}\n"

# Create the config folder
mkdir -p $OSMOSIS_HOME

# Download the binary
sudo wget -q https://github.com/osmosis-labs/osmosis/releases/download/v$OSMOSIS_VERSION/osmosisd-$OSMOSIS_VERSION-linux-$ARCH -O /usr/local/bin/osmosisd
#sudo wget -q https://osmosis-snapshots-testnet.fra1.cdn.digitaloceanspaces.com/binaries/osmosisd-$OSMOSIS_VERSION-linux-$ARCH -O /usr/local/bin/osmosisd
sudo chmod +x /usr/local/bin/osmosisd

if [ "$INSTALLATION" == "cosmovisor" ]; then
    # Installing Cosmovisor
    go install github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor@v1.0.0

    mkdir -p $OSMOSIS_HOME/cosmovisor
    mkdir -p $OSMOSIS_HOME/cosmovisor/genesis
    mkdir -p $OSMOSIS_HOME/cosmovisor/genesis/bin
    mkdir -p $OSMOSIS_HOME/cosmovisor/upgrades
    mkdir -p $OSMOSIS_HOME/cosmovisor/binaries

    sudo cp /usr/local/bin/osmosisd $OSMOSIS_HOME/cosmovisor/binaries/osmosisd-$OSMOSIS_VERSION
    sudo cp /usr/local/bin/osmosisd $OSMOSIS_HOME/cosmovisor/genesis/bin/osmosisd

    # Create Cosmovisor unit file
    echo "[Unit]
        Description=Cosmovisor daemon
        After=network-online.target
        [Service]
        Environment="DAEMON_NAME=osmosisd"
        Environment="DAEMON_HOME=$OSMOSIS_HOME"
        Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
        Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=true"
        Environment="DAEMON_LOG_BUFFER_SIZE=512"
        Environment="UNSAFE_SKIP_BACKUP=true"
        User=$USER
        ExecStart=${HOME}/go/bin/cosmovisor start --home=$OSMOSIS_HOME
        Restart=always
        RestartSec=3
        LimitNOFILE=infinity
        LimitNPROC=infinity
        [Install]
        WantedBy=multi-user.target
        " >cosmovisor.service
    sudo mv cosmovisor.service /lib/systemd/system/cosmovisor.service

fi

if [ "$INSTALLATION" == "docker" ]; then

    # Create Docker compose file
    echo "version: '3'
services:
    osmosis:
        container_name: osmosis
        command:
        - start
        - --home=/osmosis/.osmosisd
        image: osmolabs/osmosis:$OSMOSIS_VERSION
        restart: always
        ports:
        - 26656:26656
        - 26657:26657
        - 1317:1317
        volumes:
        - $OSMOSIS_HOME/:/osmosis/.osmosisd/
        " >$OSMOSIS_HOME/docker-compose.yaml

fi

# Initialize osmosis home

osmosisd init $MONIKER > /dev/null 2>&1

dasel put string -f $OSMOSIS_HOME/config/config.toml '.rpc.laddr' "tcp://0.0.0.0:26657"

# Download genesis
wget -q $GENESIS_URL -O $OSMOSIS_HOME/config/genesis.json

wget -q $ADDRBOOK_URL -O $OSMOSIS_HOME/config/addrbook.json

# Download snapshot
wget -q -O - $SNAPSHOT_URL | lz4 -d | tar -C $OSMOSIS_HOME/ -xvf -

if [ "$INSTALLATION" == "cosmovisor" ]; then
    sudo systemctl daemon-reload
    sudo systemctl enable cosmovisor.service
    sudo systemctl restart systemd-journald
    sudo systemctl start cosmovisor
fi

if [ "$INSTALLATION" == "docker" ]; then
    cd $OSMOSIS_HOME
    sudo docker compose up -d
fi

printf "${GREEN}Osmosis Node service is running ${CLEAN}\n"

sleep $WAIT

status=$(curl -s localhost:26657/status | jq '.result.sync_info.catching_up')
printf "${GREEN}Node status Catching up: $status , retrying until false ${CLEAN}\n"

while [ "$status" = "true" ]
do
  sleep $WAIT
  status=$(curl -s localhost:26657/status | jq '.result.sync_info.catching_up')
  printf "${GREEN}Node status Catching up: $status , retrying until false${CLEAN}\n"
done

printf "${GREEN}Node Catching up is no longer true, NODE IS READY! ${CLEAN}\n"
