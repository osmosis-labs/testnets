
#!/bin/bash
set -e
RED='\033[0;31m'
GREEN='\033[0;32m'
CLEAN='\033[0m'


PACKAGES="tar jq sed wget curl"

OSMOSIS_HOME=$HOME/.osmosisd
OSMOSIS_VERSION=15.1.0-testnet
CHAIN_ID=osmo-test-5

RPC_URL="https://rpc.testnet.osmosis.zone"
RPC_SERVERS="https://rpc.testnet.osmosis.zone:443,https://rpc.testnet.osmosis.zone:443"
SEEDS="$(curl -s -L https://snapshots.testnet.osmosis.zone/seeds)"
ADDRBOOK_URL=https://addrbook.testnet.osmosis.zone/
GENESIS_URL=https://genesis.testnet.osmosis.zone/genesis.json

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


printf "${GREEN}[INFO]Verifying dependencies ${CLEAN}\n"

sudo apt update >/dev/null 2>&1 || printf "${RED}Failed to run sudo apt update - please make sure you have sudo privileges ${CLEAN}\n"
for dep in $PACKAGES; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        printf "${GREEN}[INFO]Installing $dep...${GREEN}"
        sudo apt-get install "$dep" -y >/dev/null 2>&1 || printf "${RED}Failed to install $dependency ${CLEAN}\n"
    fi
done

sudo wget -q https://github.com/TomWright/dasel/releases/download/v1.20.0/dasel_linux_$ARCH -O /usr/local/bin/dasel
sudo chmod +x /usr/local/bin/dasel

# sudo wget -q https://github.com/osmosis-labs/osmosis/releases/download/v$OSMOSIS_VERSION/osmosisd-$OSMOSIS_VERSION-linux-$ARCH -O /usr/local/bin/osmosisd
sudo wget -q https://osmosis-snapshots-testnet.fra1.cdn.digitaloceanspaces.com/binaries/osmosisd-$OSMOSIS_VERSION-linux-$ARCH -O /usr/local/bin/osmosisd
sudo chmod +x /usr/local/bin/osmosisd

printf "${GREEN}[INFO]Dependencies installed... ${CLEAN}\n"

MONIKER=$1
if [ -z $MONIKER ]; then
    MONIKER=my-node
fi
printf "${GREEN}[INFO]Creating node with moniker name: $MONIKER ${CLEAN}\n"

osmosisd init $MONIKER --chain-id $CHAIN_ID > /dev/null 2>&1
wget $GENESIS_URL -O $OSMOSIS_HOME/config/genesis.json

INTERVAL=1000

LATEST_HEIGHT=$(curl -s $RPC_URL/block | jq -r .result.block.header.height)
BLOCK_HEIGHT=$(($LATEST_HEIGHT - $INTERVAL))
TRUST_HASH=$(curl -s "$RPC_URL/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

printf "${GREEN}[INFO]LATEST_HEIGHT: $LATEST_HEIGHT ${CLEAN}\n"
printf "${GREEN}[INFO]BLOCK_HEIGHT: $BLOCK_HEIGHT ${CLEAN}\n"
printf "${GREEN}[INFO]TRUST_HASH: $TRUST_HASH ${CLEAN}\n"


printf "${GREEN}[INFO]Edit config for state-sync ${CLEAN}\n"

dasel put bool -f $OSMOSIS_HOME/config/config.toml '.statesync.enable' true
dasel put int -f $OSMOSIS_HOME/config/config.toml '.statesync.trust_height' $BLOCK_HEIGHT
dasel put string -f $OSMOSIS_HOME/config/config.toml '.statesync.trust_hash' $TRUST_HASH
dasel put string -f $OSMOSIS_HOME/config/config.toml '.statesync.rpc_servers' $RPC_SERVERS

dasel put string -f $OSMOSIS_HOME/config/config.toml '.p2p.seeds' $SEEDS

wget -q $ADDRBOOK_URL -O $OSMOSIS_HOME/config/addrbook.json

printf "${GREEN}[INFO]Starting node... ${CLEAN}\n"

osmosisd start --x-crisis-skip-assert-invariants