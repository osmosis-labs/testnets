# IBC Resources

## 📺 IBC Channels

| src-chain-id  | dst-chain-id              | src-channel  | dst-channel    | Note               |
|---------------|---------------------------|--------------|----------------|--------------------|
| `osmo-test-5` | `thetha-testnet-001`      | `channel-12` | `channel-2500` | Cosmos-Hub Testnet |
| `osmo-test-5` | `uni-6`                   | `channel-1`  | `channel-190`  | Juno Testnet       |
| `osmo-test-5` | `ares-1`                  | `channel-23` | `channel-13`   | Mars Testnet       |
| `osmo-test-5` | `axelar-testnet-lisbon-3` | `channel-3`  | `channel-227`  | Axelar testnet     |
| `osmo-test-5` | `sandbox`                 | `channel-4`  | `channel-2`    | Akash testnet      |
| `osmo-test-5` | `grand-1`                 | `channel-6`  | `channel-6`    | Noble Testnet      |

## 🫰 IBC Assets

The following are all the assets currently supported by `osmo-test-5` along with their corresponding IBC denomination.

When assets are transferred through IBC, they lose their base denomination (i.e `akt`) and obtain a new IBC denomination (e.g. `ibc/4DAE26570FD24ABA40E2BE4137E39D946C78B00B248D3F78B0919567C4371156`).

| Token       | Base Denom | IBC Denom                                                              |
|-------------|------------|------------------------------------------------------------------------|
| ATOM        | `atom`     | `ibc/A8C2D23A1E6F95DA4E48BA349667E322BD7A6C996D8A4AAE8BA72E190F3D1477` |
| AKASH       | `akt`      | `ibc/4DAE26570FD24ABA40E2BE4137E39D946C78B00B248D3F78B0919567C4371156` |
| JUNO        | `junox`    | `ibc/8E2FEFCBD754FA3C97411F0126B9EC76191BAA1B3959CB73CECF396A4037BBF0` |
| MARS        | `mars`     | `ibc/0973EE75F04F14E896733FD6B6F00342E7CD7867785EE8596D3E74767BC19FC9` |
| AXELAR-USDC | `ausdc`    | `ibc/6F34E1BD664C36CE49ACC28E60D62559A5F96C4F9A6CCE4FC5A67B2852E24CFE` |
| NOBLE-USDC  | `usdc`     | `ibc/B3504E092456BA618CC28AC671A71FB08C6CA0FD0BE7C8A5B5A3E2DD933CC9E4` |

## 🧑‍💻 IBC Development

### 🚰 Faucets 

| Chain      | Chain ID                  | Faucet                                                                                   |
|------------|---------------------------|------------------------------------------------------------------------------------------|
| Osmosis    | `osmo-test-5`             | <https://faucet.osmotest5.osmosis.zone>                                                  |
| Cosmos-hub | `thetha-testnet-001`      | [🚰・testnet-faucet](https://discord.com/channels/669268347736686612/953697793476821092) |
| Juno       | `uni-6`                   | [🚰・testnet-faucet](https://discord.com/channels/816256689078403103/842073995059003422) |
| Mars       | `ares-1`                  | <https://faucet.marsprotocol.io>                                                         |
| Axelar     | `axelar-testnet-lisbon-3` | <https://faucet.testnet.axelar.dev>                                                      |
| Akash      | `sandbox`                 | <http://faucet.sandbox.ny.aksh.pw>                                                       |
| Noble      | `grand-1`                 | <http://faucet.testnet.noble.strange.love>                                               |

### Public Endpoints

The following table provides public endpoints for various blockchain networks. Please note that these endpoints are not managed by Osmosis (except for the ones under the `*.osmosis.zone` domain). 

These public endpoints are listed here solely for the purpose of simplifying development and testing of applications that interact with the respective blockchain networks. Osmosis provides no guarantee regarding the accuracy, reliability, or availability of these endpoints.

| Chain      | Chain ID                  | RPC                                                    | REST                                                    |
|------------|---------------------------|--------------------------------------------------------|---------------------------------------------------------|
| Osmosis    | `osmo-test-5`             | <https://rpc.osmotest5.osmosis.zone:443>               | <https://lcd.osmotest5.osmosis.zone:443>                |
| Cosmos-hub | `thetha-testnet-001`      | <https://rpc.sentry-01.theta-testnet.polypore.xyz:443> | <https://rest.sentry-01.theta-testnet.polypore.xyz:443> |
| Juno       | `uni-6`                   | <https://uni-rpc.reece.sh:443>                         | <https://uni-api.reece.sh:443>                          |
| Mars       | `ares-1`                  | <https://testnet-rpc.marsprotocol.io>                  | <https://testnet-rest.marsprotocol.io>                  |
| Axelar     | `axelar-testnet-lisbon-3` | <https://rpc-axelar-testnet.imperator.co:443>          | <https://lcd-axelar-testnet.imperator.co>               |
| Akash      | `sandbox`                 | <http://rpc.sandbox.ny.aksh.pw:26657>                  | <http://api.sandbox.ny.aksh.pw:1317>                    |
| Noble      | `grand-1`                 | <https://rpc.testnet.noble.strange.love:443>           | <https://api.testnet.noble.strange.love:443>            |

### 🇰 Add chains to keplr wallet 

You can add the osmo-test-5 chain to your Keplr wallet, as well as all other connected chains, at: https://keplr.osmotest5.osmosis.zone/

## 📚 Resources

The resources in these page were gathered from the following sources:

| Chain      | Chain ID                  | Source                                                                             |
|------------|---------------------------|------------------------------------------------------------------------------------|
| Cosmos-hub | `thetha-testnet-001`      | <https://github.com/cosmos/testnets/blob/master/public/README.md>                  |
| Akash      | `sandbox`                 | <https://github.com/akash-network/net/tree/master/sandbox>                         |
| Juno       | `uni-6`                   | <https://github.com/CosmosContracts/testnets/tree/main/uni-6>                      |
| Mars       | `ares-1`                  | <https://github.com/mars-protocol/networks/blob/main/ares-1>                       |
| Axelar     | `axelar-testnet-lisbon-3` | <https://docs.axelar.dev/resources>                                                |
| Noble      | `grand-1`                 | <https://github.com/strangelove-ventures/noble-networks/tree/main/testnet/grand-1> |
