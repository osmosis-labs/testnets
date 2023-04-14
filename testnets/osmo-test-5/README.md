# 🧪 osmo-test-5 testnet

## Details

| Chain ID          | `osmo-test-5`                                                      |
|-------------------|--------------------------------------------------------------------|
| Launch Date       | 6th Apr, 2023                                                      |
| Osmosisd version  | `v15.0.0`                                                          |
| Genesis           | <https://genesis.osmotest5.osmosis.zone/genesis.json>              |
| Genesis SHA256SUM | `8f84b50c0ad65582c9c52126cd33443c9f2541436ea4c525106ed9b58f7c9ef9` |

## Endpoints

Summary of the `osmo-test-5` endpoints:

| Service     | Url                                                                                                                                   |
|-------------|---------------------------------------------------------------------------------------------------------------------------------------|
| Landing     | <https://osmotest5.osmosis.zone>                                                                                                      |
| Public RPC  | <https://rpc.osmotest5.osmosis.zone>                                                                                                  |
| Public LCD  | <https://lcd.osmotest5.osmosis.zone>                                                                                                  |
| Public gRPC | <https://grpc.osmotest5.osmosis.zone>                                                                                                 |
| Seed Nodes  | `bb197876fd952d245ef6377e3651c157e3d7ed81@157.245.26.231:26656` <br/> `7c2b9e76be5c2142c76b429d9c29e902599ceb44@157.245.21.183:26656` |
| Explorer    | <https://explorer.osmotest5.osmosis.zone>                                                                                             |
| Faucet      | <https://faucet.osmotest5.osmosis.zone>                                                                                               |
| Snapshots   | <https://snapshots.osmotest5.osmosis.zone>                                                                                            |

### 🟣 Public Nodes

| Protocol | Url                                   |
|----------|---------------------------------------|
| RPC      | <https://rpc.osmotest5.osmosis.zone>  |
| gRPC     | <https://grpc.osmotest5.osmosis.zone> |
| REST     | <https://lcd.osmotest5.osmosis.zone>  |

### 🌱 Seed

| Node  | ID                                                                                                                            |
|-------|-------------------------------------------------------------------------------------------------------------------------------|
| Seeds | `bb197876fd952d245ef6377e3651c157e3d7ed81@157.245.26.231:26656,7c2b9e76be5c2142c76b429d9c29e902599ceb44@157.245.21.183:26656` |

Add the Node ID in your `p2p.seeds` section of you `config.toml`:

```toml
#######################################################
###           P2P Configuration Options             ###
#######################################################
[p2p]

# ...

# Comma separated list of seed nodes to connect to
seeds = "bb197876fd952d245ef6377e3651c157e3d7ed81@157.245.26.231:26656,7c2b9e76be5c2142c76b429d9c29e902599ceb44@157.245.21.183:26656"
```

### 🚰 Faucet

The `osmo-test-5` testnet faucet is available at <https://faucet.osmotest5.osmosis.zone>

If you are an integrator needing more funds, you can request them via [this form](https://form-integrators.osmotest5.osmosis.zone).

### 📷 Snapshots

The `osmo-test-5` snapshots are available at <https://snapshots.osmotest5.osmosis.zone/>

Get the latest snapshot:

```bash
SNAPSHOT_URL=$(curl -sL https://snapshots.osmotest5.osmosis.zone/latest)
wget -q -O - $SNAPSHOT_URL | lz4 -d | tar -C $HOME/.osmosisd/ -xvf -
```

### 🗺️ Explorer

The `osmo-test-5` testnet explorer is available at <https://explorer.osmotest5.osmosis.zone>

## Join the network

Before joining the network, ensure that your system meets the following minimum requirements:

- 4 CPU
- 8GB RAM
- 100GB free disk space

To join the Osmosis network, there are various options available. Choose the option that works best for you based on your preferences and technical requirements.

1. (Manual) Manual setup
2. (Automated) Download a snapshot and set up Cosmovisor
3. (Automated) Download a snapshot and set up Docker
4. (Automated) Use state sync

###  Option 1: Manual setup

Make sure you have `jq`, `wget` and `curl` present in your machine.

1. Download the `osmosisd` binary: 

```bash
# Find out network version           
RPC_ABCI_INFO=$(curl -s --retry 5 --retry-delay 5 --connect-timeout 30 -H "Accept: application/json" https://rpc.osmotest5.osmosis.zone/abci_info)
NETWORK_VERSION=$(echo $RPC_ABCI_INFO | jq  -r '.result.response.version')

# Download osmosisd binary
wget https://github.com/osmosis-labs/osmosis/releases/download/v$NETWORK_VERSION/osmosisd-$NETWORK_VERSION-linux-amd64 -O ./osmosisd

# For arm:
# wget https://github.com/osmosis-labs/osmosis/releases/download/v$NETWORK_VERSION/osmosisd-$NETWORK_VERSION-linux-arm64 -O ./osmosisd

chmod +x ./osmosisd
sudo mv ./osmosisd /usr/local/bin/osmosisd
```

2. Initialize the node:

```bash
MONIKER=my-node
osmosisd init $MONIKER --chain-id osmo-test-5 --home $HOME/.osmosisd
```

3. Download genesis 

```bash
wget -q https://genesis.osmotest5.osmosis.zone/genesis.json -O $HOME/.osmosisd/config/genesis.json
```

4. Download the latest snapshot:

```bash
SNAPSHOT_URL=$(curl -sL https://snapshots.osmotest5.osmosis.zone/latest)
wget -q -O - $SNAPSHOT_URL | lz4 -d | tar -C $HOME/.osmosisd/ -xvf -
```

5. Set the seed node in the `config.toml`:

```bash
SEED_NODE_ID="bb197876fd952d245ef6377e3651c157e3d7ed81@157.245.26.231:26656,7c2b9e76be5c2142c76b429d9c29e902599ceb44@157.245.21.183:26656"
sed -i "s/^seeds = .*/seeds = \"$SEED_NODE_ID\"/" $HOME/.osmosisd/config/config.toml
```

6. Start the node:

```bash
osmosisd start --home $HOME/.osmosisd
```

###  Option 2: Download a snapshot and set up Cosmovisor

If you prefer to join the network by downloading a snapshot and using Cosmovisor:

1. Set the `INSTALLATION` variable to `cosmovisor` and the `MONIKER` variable to a name for your node. 

```bash
export INSTALLATION=cosmovisor 
export MONIKER=my-node
```

2. Then, download and execute the `join-network.sh ` script by running the following command:

```bash
curl -s -L https://raw.githubusercontent.com/osmosis-labs/testnets/main/testnets/osmo-test-5/scripts/join-snapshot.sh | bash -s $INSTALLATION $MONIKER
```

###  Option 3: Download a snapshot and set up Docker

If you prefer to join the network by downloading a snapshot and using docker:

1. Set the `INSTALLATION` variable to `docker` and the `MONIKER` variable to a name for your node. 

```bash
export INSTALLATION=docker 
export MONIKER=my-node
```

2. Then, download and execute the `join-network.sh ` script by running the following command:

```bash
curl -s -L https://raw.githubusercontent.com/osmosis-labs/testnets/main/testnets/osmo-test-5/scripts/join-snapshot.sh | bash -s $INSTALLATION $MONIKER
```

### Option 4: Use the state-sync script

If you prefer to join the network using state-sync:

1. Set the `MONIKER` variable to a name for your node:

```bash
export MONIKER=my-node
```

2. Download and execute the state-sync script:

```bash
curl -s -L https://raw.githubusercontent.com/osmosis-labs/testnets/main/testnets/osmo-test-5/scripts/join-state-sync.sh | bash -s $MONIKER
```

## Genesis and Network Parameters

The testnet genesis can be found at <https://genesis.osmotest5.osmosis.zone/genesis.json>.

The following modifications were made to the app state parameters:

- `day` epoch was set to `21600s` (6 hours)
- `gamm.pool_creation_fee` set to `10000000uosmo`
- `poolmanager.pool_creation_fee` set to `10000000uosmo`
- `gov.min_deposit` set to `10000000uosmo`
- `gov.min_expedited_deposit` set to `50000000uosmo`
- `voting_params.voting_period` set to 180s
- `voting_params.expedited_voting_period` set to 180s
- `incentives.lockable_durations` set to `[ "3600s", "10800s", "25200s", "60s" ]`
- `poolincentives.lockable_durations` set to `[ "3600s", "10800s", "25200s", "60s" ]`
- `staking.unbonding_time` set to `300s`
- `tokenfactory.denom_creation_fee` set to `10000000uosmo`
- `wasm.instantiate_default_permission` set to `Everybody` (yay! Go CosmWasm!)