# 🧪 osmo-test-4 testnet

## Details

| Chain ID          | `osmo-test-4`                                                                   |
|-------------------|---------------------------------------------------------------------------------|
| Launch Date       | 26th Feb, 2022                                                                  |
| Osmosisd version  | `v15.0.0-rc4`                                                                   |
| Genesis           | <https://github.com/osmosis-labs/networks/raw/main/osmo-test-4/genesis.tar.bz2> |
| Genesis SHA256SUM | `8f84b50c0ad65582c9c52126cd33443c9f2541436ea4c525106ed9b58f7c9ef9`              |

## Endpoints

Summary of the `osmo-test-4` endpoints:

| Service     | Url                                                                                                                                    |
|-------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Public RPC  | <https://rpc.testnet.osmosis.zone>                                                                                                     |
| Public LCD  | <https://grpc.testnet.osmosis.zone>                                                                                                    |
| Public gRPC | <https://lcd.testnet.osmosis.zone>                                                                                                     |
| Seed Node   | `0f9a9c694c46bd28ad9ad6126e923993fc6c56b1@137.184.181.105:26656`                                                                       |
| Peers       | `4ab030b7fd75ed895c48bcc899b99c17a396736b@137.184.190.127:26656` <br/> `3dbffa30baab16cc8597df02945dcee0aa0a4581@143.198.139.33:26656` |
| Explorer    | <https://testnet.mintscan.io/osmosis-testnet>                                                                                          |
| Faucet      | <https://faucet.osmosis.zone>                                                                                                          |
| Frontend    | <https://testnet.osmosis.zone>                                                                                                         |

### 🟣 Public Nodes

| Protocol | Url                                 |
|----------|-------------------------------------|
| RPC      | <https://rpc.testnet.osmosis.zone>  |
| gRPC     | <https://grpc.testnet.osmosis.zone> |
| REST     | <https://lcd.testnet.osmosis.zone>  |

### 🌱 Seed

| Node | ID                                                               |
|------|------------------------------------------------------------------|
| Seed | `0f9a9c694c46bd28ad9ad6126e923993fc6c56b1@137.184.181.105:26656` |

Add the Node ID in your `p2p.seeds` section of you `config.toml`:


```toml
#######################################################
###           P2P Configuration Options             ###
#######################################################
[p2p]

# ...

# Comma separated list of seed nodes to connect to
seeds = "0f9a9c694c46bd28ad9ad6126e923993fc6c56b1@137.184.181.105:26656"
```

### 🚰 Faucet

The `osmo-test-4` testnet faucet is available at <https://faucet.osmosis.zone>


## Join the network

Before joining the network, ensure that your system meets the following minimum requirements:

- 4 CPU
- 8GB RAM
- 100GB free disk space

To join the Osmosis network, there are various options available. Choose the option that works best for you based on your preferences and technical requirements.

1. (Manual) Manual setup
2. (Automated) Osmosis installer

###  Option 1: Manual setup

Make sure you have `jq`, `wget` and `curl` present in your machine.

1. Download the `osmosisd` binary: 

```bash
# Find out network version           
RPC_ABCI_INFO=$(curl -s --retry 5 --retry-delay 5 --connect-timeout 30 -H "Accept: application/json" https://rpc.testnet.osmosis.zone/abci_info)
NETWORK_VERSION=$(echo $RPC_ABCI_INFO | jq  -r '.result.response.version')

# Download osmosisd binary
git clone https://github.com/osmosis-labs/osmosis/
cd osmosis
git checkout https://github.com/osmosis-labs/osmosis/releases/tag/v15.0.0-rc4
make build

chmod +x ./build/osmosisd
sudo mv ./build/osmosisd /usr/local/bin/osmosisd
```

2. Initialize the node:

```bash
MONIKER=my-node
osmosisd init $MONIKER --chain-id osmo-test-4 --home $HOME/.osmosisd
```

3. Download genesis 

```bash
wget -O - https://github.com/osmosis-labs/networks/raw/main/osmo-test-4/genesis.tar.bz2 | tar -xzvf - -C $HOME/.osmosisd/config/
```

4. Download the latest snapshot:

```bash
SNAPSHOT_URL=$(curl https://quicksync.io/osmosis.json|jq -r '.[] |select(.file=="osmotestnet-4-pruned")|select (.mirror=="Netherlands")|.url')
wget -q -O - $SNAPSHOT_URL | lz4 -d | tar -C $HOME/.osmosisd/ -xvf -
```

5. Set the seed node in the `config.toml`:

```bash
SEED_NODE_ID="0f9a9c694c46bd28ad9ad6126e923993fc6c56b1@137.184.181.105:26656"
sed -i "s/^seeds = .*/seeds = \"$SEED_NODE_ID\"/" $HOME/.osmosisd/config/config.toml
```

6. Start the node:

```bash
osmosisd start --home $HOME/.osmosisd
```

###  Option 2: Osmosis Installer

Please refer to the official documentation <https://docs.osmosis.zone/networks/join-testnet>