# 🧪 osmo-test-5 testnet

## Details

| Chain ID          | `osmo-test-5`                                                      |
|-------------------|--------------------------------------------------------------------|
| Launch Date       | 6th Apr, 2023                                                      |
| Osmosisd version  | `v19.0.0-rc0`                                                      |
| Genesis           | <https://genesis.testnet.osmosis.zone/genesis.json>                |
| Genesis SHA256SUM | `8f84b50c0ad65582c9c52126cd33443c9f2541436ea4c525106ed9b58f7c9ef9` |

> Add `osmo-test-5` to keplr: <https://keplr.testnet.osmosis.zone/>

## Endpoints

Summary of the `osmo-test-5` endpoints:

| Service             | Url                                                                                                                                                                                                         |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Landing             | <https://landing.testnet.osmosis.zone>                                                                                                                                                                            |
| Public RPC          | <https://rpc.testnet.osmosis.zone>                                                                                                                                                                        |
| Public LCD          | <https://lcd.testnet.osmosis.zone>                                                                                                                                                                        |
| Public gRPC         | <https://grpc.testnet.osmosis.zone>                                                                                                                                                                       |
| Osmosis Seed Nodes  |  |
| External Seed Nodes | `f440c4980357d8b56db87ddd50f06bd551f1319a@5.78.98.19:26656` <br/> `ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:12556`                                                               |
| Explorers           | <https://testnet.mintscan.io/osmosis-testnet/> <br/> <https://explorer.testnet.osmosis.zone>                                                                                                              |
| Faucet              | <https://faucet.testnet.osmosis.zone>                                                                                                                                                                     |
| Snapshots           | <https://snapshots.testnet.osmosis.zone>                                                                                                                                                                  |
| Addressbook           | <https://rpc.testnet.osmosis.zone/addrbook>                                                                                                                                                                  |

### 📚 External Resources
 
The following resources were provided by validators and integrators, whom we would like to thank for their contributions to Osmosis:

| Resource             | Url                                        |
|----------------------|--------------------------------------------|
| Polkachu Testnet Lab | https://www.polkachu.com/testnets/osmosis  |
| Quicksync            | https://quicksync.io/networks/osmosis.html |

If you want to be listed in this table, contribute by opening a PR and suggesting a new resource.

### 🟣 Public Nodes

| Protocol | Url                                   |
|----------|---------------------------------------|
| RPC      | <https://rpc.testnet.osmosis.zone>  |
| gRPC     | <https://grpc.testnet.osmosis.zone> |
| REST     | <https://lcd.testnet.osmosis.zone>  |

### 🌱 Seed

| Node          | ID                                                                                                                                                                                                          |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Osmosis Seed  | |
| External Seed | `f440c4980357d8b56db87ddd50f06bd551f1319a@5.78.98.19:26656` <br/> `ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:12556`                                                               |

Add the Node ID in your `p2p.seeds` section of you `config.toml`:

```toml
#######################################################
###           P2P Configuration Options             ###
#######################################################
[p2p]

# ...

# Comma separated list of seed nodes to connect to
seeds = "7c2b9e76be5c2142c76b429d9c29e902599ceb44@157.245.21.183:26656,05c41cc1fc7c8cb379e54d784bcd3b3907a1568e@157.245.26.231:26656,7c2b9e76be5c2142c76b429d9c29e902599ceb44@157.245.21.183:26656,f440c4980357d8b56db87ddd50f06bd551f1319a@5.78.98.19:26656,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:12556"
```

### 🚰 Faucet

The `osmo-test-5` testnet faucet is available at <https://faucet.testnet.osmosis.zone>

If you are an integrator needing more funds, you can request them via [this form](https://form-integrators.testnet.osmosis.zone).

### 📷 Snapshots

The `osmo-test-5` snapshots are available at <https://snapshots.testnet.osmosis.zone/>

Get the latest snapshot:

```bash
SNAPSHOT_URL=$(curl -sL https://snapshots.testnet.osmosis.zone/latest)
wget -q -O - $SNAPSHOT_URL | lz4 -d | tar -C $HOME/.osmosisd/ -xvf -
```

#### Latest Archive Snapshot

| Blocks     | Url                                                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------------------------------|
| 1 - 466372 | http://osmosis-snapshots-testnet.fra1.digitaloceanspaces.com/snapshots-archive/osmotest5-snapshot-202305031411-466372.tar.lz4 |

### 🗺️ Explorer

The `osmo-test-5` testnet explorer is available at <https://explorer.testnet.osmosis.zone>

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
RPC_ABCI_INFO=$(curl -s --retry 5 --retry-delay 5 --connect-timeout 30 -H "Accept: application/json" https://rpc.testnet.osmosis.zone/abci_info)
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
wget -q https://genesis.testnet.osmosis.zone/genesis.json -O $HOME/.osmosisd/config/genesis.json
```

4. Download the latest snapshot:

```bash
SNAPSHOT_URL=$(curl -sL https://snapshots.testnet.osmosis.zone/latest)
wget -q -O - $SNAPSHOT_URL | lz4 -d | tar -C $HOME/.osmosisd/ -xvf -
```

5. Download the addressbook:

```bash
wget -q https://rpc.testnet.osmosis.zone/addrbook -O $HOME/.osmosisd/config/addrbook.json
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

The testnet genesis can be found at <https://genesis.testnet.osmosis.zone/genesis.json>.

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
- `staking.unbonding_time` set to `86400s`
- `tokenfactory.denom_creation_fee` set to `10000000uosmo`
- `wasm.instantiate_default_permission` set to `Everybody` (yay! Go CosmWasm!)
