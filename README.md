# FEVM Foundry Kit

A Foundry template that provides basic scaffolding for quickly getting started with new Filecoin EVM (FEVM) projects.

## Prerequisites

### Download Foundry

Install Foundry by following the instructions in the [official Foundry repository](https://github.com/foundry-rs/foundry#installation).

## Getting Started

### Clone the Repository

Open your terminal (or command prompt) and navigate to the directory where you want to store this code. Then run the following commands:

```bash
git clone https://github.com/filecoin-project/fevm-foundry-kit
cd fevm-foundry-kit
forge build
npm install
```

This will clone the repository to your computer, navigate to the newly created directory, install the required dependencies, build the project and compile the contracts.

### Set Up Your Private Key

You can obtain a private key from a wallet provider such as [MetaMask](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-export-an-account-s-private-key).

### Configure Environment Variables

Add your private key as an environment variable by running this command:

```bash
export PRIVATE_KEY='your_private_key_here'
```

Alternatively, to avoid setting this every time, create a `.env` file in the root directory of the project (you can use `.env.example` as a template) and add the following lines:

```bash
PRIVATE_KEY=your_private_key_here
CALIBRATIONNET_RPC_URL=https://api.calibration.node.glif.io/rpc/v1
```

Then, in a new terminal, run:

```bash
source .env
```

**⚠️ Security Warning:** Never commit or push `.env` files that contain sensitive information such as private keys! If this information reaches a public GitHub repository, someone could potentially access your wallet and steal your funds.

### Fund Your Deployer Address

Visit the [Calibrationnet testnet faucet](https://faucet.calibnet.chainsafe-fil.io/funds.html) and paste in your Ethereum address. This will send testnet FIL to your account for deployment and testing.

## Contract Deployment

This kit includes three main types of contracts:

- **Basic Solidity Examples**: Simple contracts demonstrating basic Solidity functionality
- **Filecoin API Examples**: Contracts that demonstrate how to use Filecoin APIs in Solidity to access storage deals and other Filecoin-specific functions
- **Basic Deal Client**: A contract that demonstrates how to create Filecoin storage deals within Solidity smart contracts

### Deploy to Calibrationnet (Testnet)

Let's deploy the DealClient contract to Calibrationnet:

```bash
forge create --rpc-url https://api.calibration.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --broadcast src/basic-deal-client/DealClient.sol:DealClient
```

This will deploy the DealClient contract to the Calibrationnet testnet. You'll see output similar to:

```
Deployer: 0x42C930A33280a7218bc924732d67dd84D6247Af4
Deployed to: 0xb364aA01595fbC73c07B6F318dce9A34a1e8527b
Transaction hash: 0x858f01f8fa090cfe89c92754dd777bf4f2aad688502f05dfc9e57738f162392a
```

### Verify Contracts on Calibrationnet

#### Verify on Blockscout

```bash
forge verify-contract --rpc-url https://api.calibration.node.glif.io/rpc/v1 --verifier blockscout --verifier-url 'https://filecoin-testnet.blockscout.com/api/' --force --skip-is-verified-check $DEPLOYED_CONTRACT_ADDRESS src/basic-solidity-examples/SimpleCoin.sol:SimpleCoin
```

#### Verify on Filfox

Use the [@fil-b/filfox-verifier](https://www.npmjs.com/package/@fil-b/filfox-verifier) package:

```bash
filfox-verifier forge $DEPLOYED_CONTRACT_ADDRESS src/basic-deal-client/DealClient.sol:DealClient --chain 314159
```

Successful verification will display:

```
⠸ Verifying contract on Filfox...

Verification Result:
✔ ✅ Contract "DealClient" verified successfully!
✔ 🔗 View at: https://calibration.filfox.info/en/address/0xb364aA01595fbC73c07B6F318dce9A34a1e8527b
```

### Deploy to Filecoin Mainnet

**Make sure your wallet has FIL tokens to perform the Mainnet deployment!**

Now let's deploy the SimpleCoin contract to Filecoin Mainnet:

```bash
forge create --rpc-url https://api.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --broadcast src/basic-solidity-examples/SimpleCoin.sol:SimpleCoin
```

This will deploy the SimpleCoin contract to Filecoin Mainnet. You'll see output similar to:

```
Deployer: 0x42C930A33280a7218bc924732d67dd84D6247Af4
Deployed to: 0xE3822FC46fF629B3cb8e6FF1cCD4AF61Ca8B601d
Transaction hash: 0x8c39a5266faeae27905f18f8a69aab6081b0a5e03a4a7c219bd8a5977c614594
```

### Verify Contracts on Filecoin Mainnet

#### Verify on Blockscout

```bash
forge verify-contract --rpc-url https://api.node.glif.io/rpc/v1 --verifier blockscout --verifier-url 'https://filecoin.blockscout.com/api/' --force --skip-is-verified-check $DEPLOYED_CONTRACT_ADDRESS src/basic-solidity-examples/SimpleCoin.sol:SimpleCoin
```

You'll receive a response like:

```
Start verifying contract `0xE3822FC46fF629B3cb8e6FF1cCD4AF61Ca8B601d` deployed on filecoin-mainnet

Submitting verification for [src/basic-solidity-examples/SimpleCoin.sol:SimpleCoin] 0xE3822FC46fF629B3cb8e6FF1cCD4AF61Ca8B601d.
Submitted contract for verification:
        Response: `OK`
        GUID: `e3822fc46ff629b3cb8e6ff1ccd4af61ca8b601d6890958b`
        URL: https://filecoin.blockscout.com/address/0xe3822fc46ff629b3cb8e6ff1ccd4af61ca8b601d
```

#### Verify on Filfox

```bash
filfox-verifier forge $DEPLOYED_CONTRACT_ADDRESS src/basic-solidity-examples/SimpleCoin.sol:SimpleCoin --chain 314
```

A successful response will look like:

```
⠧ Verifying contract on Filfox...

Verification Result:
✔ ✅ Contract "SimpleCoin" verified successfully!
✔ 🔗 View at: https://filfox.info/en/address/0xE3822FC46fF629B3cb8e6FF1cCD4AF61Ca8B601d
```

## Interacting with Contracts

### Using Forge Scripts

You can interact with contracts using Forge scripts located in the `script/` folder. For example, to interact with the SimpleCoin contract:

```bash
forge script script/SimpleCoin.s.sol:MyScript --rpc-url https://api.calibration.node.glif.io/rpc/v1 --broadcast --skip-simulation
```

### Using Cast

You can also interact with contracts via the command line using the [Foundry cast tool](https://book.getfoundry.sh/cast/#overview-of-cast).

## Troubleshooting

### Empty Transaction Receipts

Some users encounter issues where transactions show empty receipts on testnet but appear successful on block explorers:

```
Error: 
Received an empty receipt for 0xe661e7a4e5ec511c93c2b966ae382da9267c5ad217d9b5ec75de3ce3ab848608
```

Or transactions that appear to be dropped from the mempool but show up on explorers:

```
Error: 
Transaction dropped from the mempool: 0x9b293d053a0c148677b46425f143fd46dd58d13b47251208d68c458653f30038
```

**Solutions:**
- Increase the number of retry attempts using the `--resume` flag, ideally setting it to ~10 with `--retries`
- Alternatively, use ethers-rs to handle contract transactions. There's a [send_tx](https://github.com/filecoin-saturn/rs-fevm-utils/blob/5c850005bbe50d7547d2585173ab2bd39c47c011/src/lib.rs#LL215C4-L215C4) function that allows you to override the default number of retries.

## Filecoin APIs

The primary advantage of the FEVM over other EVM-based chains is the ability to access and program around Filecoin storage deals. This can be done in the FEVM via the [Filecoin.sol library maintained by Zondax](https://github.com/Zondax/filecoin-solidity). **Note this library is currently in BETA**. It is unaudited, and the APIs will likely be changing with time. This repo will be updated as soon as possible when a breaking change occurs.

The library is included in this kit as a submodule and will be automatically downloaded when you run the `forge build` command (don't confuse this with the included mocks).

Currently, you'll find a getter contract that calls the getter methods on the MarketAPI to retrieve and store storage deal data. To use this, you'll need *dealIDs* which you can [find on FilFox](https://calibration.filfox.info/en/deal).

### Preparing Data for Storage

Before storing a file with a storage provider, it needs to be prepared by converting it to a .car file and recording the metadata. You can do this locally using [this tool](https://github.com/filecoin-project/fevm-hardhat-kit/tree/main/tools), written in Go. Alternatively, you can use the [FVM Data Depot website](https://data.lighthouse.storage/), which automatically converts files to the .car format, outputs all necessary metadata, and acts as an HTTP retrieval point for storage providers.

### DealClient Contract - Making Storage Deals in Solidity

In the `src/basic-deal-client/` directory, you'll find `DealClient.sol`. This example contract uses the Filecoin.sol APIs to create storage deals via Solidity smart contracts on Filecoin. It works by emitting a Solidity event that [Boost storage providers](https://boost.filecoin.io/) can listen to. For more information about this contract, check out the [app kit repository](https://github.com/filecoin-project/fvm-starter-kit-deal-making), which includes a detailed README and frontend.

### DealRewarder Contract

In the `src/filecoin-api-examples/` directory, you'll find `DealRewarder.sol`. This basic example contract uses the Filecoin.sol APIs to create bounties for specific data to be stored on the Filecoin blockchain. It's intended as an example to illustrate how you can use the Filecoin APIs for interesting functionality. For more information about this contract, check out the [original Foundry project](https://github.com/lotus-web3/deal-bounty-contract), which includes a detailed README.

