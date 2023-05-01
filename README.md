<div>
    <img src="https://avatars.githubusercontent.com/u/105710778?v=4" align="left" width="110" style="margin-right: 15px"/>
    <h1>   
        🧪 Osmosis Testnets
    </h1>
    <p> This repository contains information on Osmosis public testnets </p>
    <br>
</div>

| Chain ID                              | Type      | Status     | Version           | Notes            |
|---------------------------------------|-----------|------------|-------------------|------------------|
| [osmo-test-4](./testnets/osmo-test-4) | *testnet* | Deprecated | `v15.0.0-rc4`     | Previous testnet |
| [osmo-test-5](./testnets/osmo-test-5) | *testnet* | Active     | `v15.1.0-testnet` | Current testnet  |

## Testnets

### 🟪 osmo-test-4

| Chain ID         | `osmo-test-4`                                                                   |
|------------------|---------------------------------------------------------------------------------|
| Osmosisd version | `v15.0.0-rc4`                                                                   |
| Genesis          | <https://github.com/osmosis-labs/networks/raw/main/osmo-test-4/genesis.tar.bz2> |
| RPC              | <https://rpc.testnet.osmosis.zone>                                              |
| gRPC             | <https://grpc.testnet.osmosis.zone>                                             |
| REST             | <https://lcd.testnet.osmosis.zone>                                              |
| Faucet           | <https://faucet.osmosis.zone>                                                   |
| Frontend         | <https://testnet.osmosis.zone>                                                  |

#### Join the testnet 

Join the testnet following the instructions on the [osmo-test-4 page](./testnets/osmo-test-4/README.md).

### 🟪 osmo-test-5

| Chain ID         | `osmo-test-5`                                        |
|------------------|------------------------------------------------------|
| Osmosisd version | `v15.1.0-testnet`                                    |
| Genesis          | <http://genesis.osmotest5.osmosis.zone/genesis.json> |
| RPC              | <https://rpc.osmotest5.osmosis.zone>                 |
| gRPC             | <https://grpc.osmotest5.osmosis.zone>                |
| REST             | <https://lcd.osmotest5.osmosis.zone>                 |
| Faucet           | <https://faucet.osmotest5.osmosis.zone>              |
| Explorer         | <https://explorer.osmotest5.osmosis.zone>            |
| Snapshots        | <https://snapshots.osmotest5.osmosis.zone>           |
| Frontend         | <https://app.osmotest5.osmosis.zone>  (WIP 🛠️)       |

#### 🧪 Join the testnet 

Join the testnet following the instructions on the [osmo-test-5 page](./testnets/osmo-test-5/README.md).

## 🆘 Issues and support

If you encounter any issues while joining the Osmosis network or have questions about the process, please don't hesitate to reach out for support.

- For general questions and community support, join the [Osmosis Discord](https://discord.com/channels/798583171548840026/888527640099688458) and ask in the `#testnet-discusion` channel.

- For technical issues or bugs related to the testnet, submit a detailed issue report on this repository with a clear description of the problem and any relevant error messages or logs.

## 🙋‍♀️ FAQ

**1) Will the `osmo-test-4` be deleted?**

Yes, the `osmo-test-4` testnet will be deprecated and eventually deleted in favor of the `osmo-test-5` testnet. The transition will occur in stages to minimize disruption for users and integrators:

- During April, `osmo-test-4` will remain the official testnet while `osmo-test-5` will be in public beta.
- During May, `osmo-test-4` will be deprecated (but not removed) and the official testnet will become `osmo-test-5`.
- On June 1st, `osmo-test-4` will be deleted.

If you're currently using `osmo-test-4`, we encourage you to migrate to `osmo-test-5` to ensure that your development and testing are not interrupted. If you have any questions or concerns about the transition, please don't hesitate to reach out on the `#testnet-discusion` channel on [Osmosis Discord](https://discord.com/channels/798583171548840026/888527640099688458).

**2) I need some funds on the `osmo-test-5` testnet, how can I get them?**

You can request testnet tokens for the `osmo-test-5` testnet from the faucet available at <https://faucet.osmotest5.osmosis.zone>. Please note that the faucet currently dispenses up to 100 OSMO per day per address.

**3) I am an integrator on the `osmo-test-5` testnet. How can I request more funds?**

If you are an integrator needing additional testnet tokens for development or testing purposes, you can request them via [this form](https://form-integrators.osmotest5.osmosis.zone). Please provide detailed information about your project and the number of tokens you require, and our team will review your request as soon as possible.
