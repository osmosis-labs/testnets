<div>
    <img src="https://avatars.githubusercontent.com/u/105710778?v=4" align="left" width="110" style="margin-right: 15px"/>
    <h1>   
        🧪 Osmosis Testnets
    </h1>
    <p> This repository contains information on Osmosis public testnets and devnets </p>
    <br>
</div>

| Chain ID                              | Type      | Status     | Version       | Notes                     |
|---------------------------------------|-----------|------------|---------------|---------------------------|
| [osmo-test-5](./testnets/osmo-test-5) | `testnet` | **Active** | `v26.0.0` | Testnet                       |
| [devnet](./devnets/devnet)            | `devnet`  | **Beta**   | `v19.1.0`     | Devnet with mainnet state |
<!-- | [edgenet](./devnets/edgenet)            | `devnet`  | **Beta**   | `v18.x`        | Daily devnet based of `osmosis/v18.x` branch   | -->

## Testnets

Testnets are a type of blockchain used exclusively for testing purposes. They function as a sandbox environment, allowing developers to test new code and functionalities without worrying about affecting the live blockchain (mainnet). They are persistent environments, meaning that they remain active for extended periods of time.

Testnets come with a range of integrated services, including relayers to other testnets, frontends, explorers, and snapshot services. 

### 🟪 osmo-test-5

| Chain ID         | `osmo-test-5`                                      |
|------------------|----------------------------------------------------|
| Osmosisd version | `v26.0.0`                                          |
| Genesis          | <http://genesis.testnet.osmosis.zone/genesis.json> |
| RPC              | <https://rpc.testnet.osmosis.zone>                 |
| gRPC             | <https://grpc.testnet.osmosis.zone>                |
| REST             | <https://lcd.testnet.osmosis.zone>                 |
| Faucet           | <https://faucet.testnet.osmosis.zone>              |
| Explorer         | <https://explorer.testnet.osmosis.zone>            |
| Snapshots        | <https://snapshots.testnet.osmosis.zone>           |
| Frontend         | <https://testnet.osmosis.zone>                     |

#### 🧪 Join the testnet 

Join the testnet following the instructions on the [osmo-test-5 page](./testnets/osmo-test-5/README.md).

## Devnets

Devnets, short for development networks, are also used for testing new functionalities and code. However, unlike testnets, devnets are temporary environments. They are essentially forks of the mainnet, created to mimic the live blockchain's conditions as closely as possible.

Devnets are ephemeral, which means they are deleted and recreated every 24 hours. This ensures that the testing environment closely mirrors the current state of the mainnet. Devnets are minimal environments, consisting only of a validator. Unlike testnets, devnets do not feature frontends or relayers to other testnets. 

<!-- 
### 🟨 edgenet

| Chain ID         | `edgenet`                                                                 |
|------------------|---------------------------------------------------------------------------|
| Osmosisd version | `osmosis/main` branch                                                     |
| Genesis          | <https://osmosis.fra1.digitaloceanspaces.com/edgenet/genesis.json>        |
| Starting Height  | <https://osmosis.fra1.digitaloceanspaces.com/edgenet/height>              |
| RPC              | <https://rpc.edgenet.osmosis.zone>                                        |
| REST             | <https://lcd.edgenet.osmosis.zone>                                        |
| gRPC             | `grpc.edgenet.osmosis.zone:30090`                                         |
| websocket        | `wss://rpc.edgenet.osmosis.zone:443/websocket`                            |
| Faucet           | <https://faucet.edgenet.osmosis.zone>                                     |
| Seed Node        | `ad717b5090f2c8370c023e7925eabe3cf73f3014@p2p.edgenet.osmosis.zone:30056` | 
-->

### 🟨 devnet

| Chain ID         | `devnet`                                                                 |
|------------------|--------------------------------------------------------------------------|
| Osmosisd version | `v19.1.0`                                                                |
| Genesis          | <https://osmosis.fra1.digitaloceanspaces.com/devnet/genesis.json>        |
| Starting Height  | <https://osmosis.fra1.digitaloceanspaces.com/devnet/height>              |
| RPC              | <https://rpc.devnet.osmosis.zone>                                        |
| REST             | <https://lcd.devnet.osmosis.zone>                                        |
| gRPC             | `grpc.devnet.osmosis.zone:30090`                                         |
| websocket        | `wss://rpc.devnet.osmosis.zone:443/websocket`                            |
| Faucet           | <https://faucet.devnet.osmosis.zone>                                     |
| Seed Node        | `5943e04edc5397018803f73e47f826be016010e1@p2p.devnet.osmosis.zone:30056` |

## 🆘 Issues and support

If you encounter any issues while joining the Osmosis network or have questions about the process, please don't hesitate to reach out for support.

- For general questions and community support, join the [Osmosis Discord](https://discord.com/channels/798583171548840026/888527640099688458) and ask in the `#testnet-discusion` channel.

- For technical issues or bugs related to the testnet, submit a detailed issue report on this repository with a clear description of the problem and any relevant error messages or logs.

## 🙋‍♀️ FAQ

**1) I need some funds on the `osmo-test-5` testnet, how can I get them?**

You can request testnet tokens for the `osmo-test-5` testnet from the faucet available at <https://faucet.testnet.osmosis.zone>. Please note that the faucet currently dispenses up to 100 OSMO per day per address.

**2) I am an integrator on the `osmo-test-5` testnet. How can I request more funds?**

If you are an integrator needing additional testnet tokens for development or testing purposes, you can request them via [this form](https://form-integrators.testnet.osmosis.zone). Please provide detailed information about your project and the number of tokens you require, and our team will review your request as soon as possible.

**3) What are the differences between testnets and devnets?**

| **Features** | **Testnets**             | **Devnets**                                      |
|--------------|--------------------------|--------------------------------------------------|
| Persistent   | ✅                        | ❌ they are deleted and recreated every 24 hours. |
| State        | Maintains its own state. | Forks of the mainnet, mimicking its state.       |
| Faucet       | ✅                        | ✅                                                |
| Explorer     | ✅                        | ❌                                                |
| Frontend     | ✅                        | ❌                                                |
| Relayers     | ✅                        | ❌                                                |
