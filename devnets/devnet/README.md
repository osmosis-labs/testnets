# 🧪 devnet

> This page is a work in progress. Please check back later for more information.

## Details

| Chain ID         | `devnet`                                                          |
|------------------|-------------------------------------------------------------------|
| Osmosisd version | `osmosis/v15` branch                                              |
| Genesis          | <https://osmosis-devnet.sfo3.digitaloceanspaces.com/genesis.json> |
| Starting Height  | <https://osmosis-devnet.sfo3.digitaloceanspaces.com/height>       |

### 🟣 Public Nodes

| Protocol  | Url                                           |
|-----------|-----------------------------------------------|
| RPC       | <https://rpc.devnet.osmosis.zone>             |
| REST      | <https://lcd.devnet.osmosis.zone>             |
| gRPC      | `grpc.devnet.osmosis.zone:30090`              |
| websocket | `wss://rpc.devnet.osmosis.zone:443/websocket` |

### 🌱 Seed

| Node      | ID                                                                       |
|-----------|--------------------------------------------------------------------------|
| Seed Node | `5943e04edc5397018803f73e47f826be016010e1@p2p.devnet.osmosis.zone:30056` |

### 🚰 Faucet

The `devnet` testnet faucet is available at <https://faucet.devnet.osmosis.zone>

Given that this devnet is a state export, your mainnet funds would be available on the `devnet` as testnet tokens.
Please be extremely careful about explicitly checking the `chain-id` before signing any transactions.
