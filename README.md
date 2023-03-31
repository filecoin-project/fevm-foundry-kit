# FEVM Foundry Kit

This is a template for foundry that provides the basic scaffolding for quickly getting started with new projects. 

## Download Foundry

You can find the instructions to download Foundry in the [official Foundry repo](https://github.com/foundry-rs/foundry#installation). 

## Cloning the Repo

Open up your terminal (or command prompt) and navigate to a directory you would like to store this code on. Once there type in the following command:


```
git clone https://github.com/xBalbinus/fevm-foundry-kit
cd fevm-foundry-kit
yarn install
```

This will clone the hardhat kit onto your computer, switch directories into the newly installed kit, and install the dependencies the kit needs to work.

## Get a Private Key

You can get a private key from a wallet provider [such as Metamask](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-export-an-account-s-private-key).


## Add your Private Key as an Environment Variable

Add your private key as an environment variable by running this command:

```
export PRIVATE_KEY='abcdef'
```

Alternatively, to avoid having to do that every time, create a .env file in the root directory of the project (you can use .env.example to do so easily) and add the following line:

```
PRIVATE_KEY=abcdef
HYPERSPACE_RPC_URL=https://api.hyperspace.node.glif.io/rpc/v1
```

and then, open a new terminal and run the following command:

```
source .env
```

If you use a .env file, don't commit and push any changes to .env files that may contain sensitive information, such as a private key! If this information reaches a public GitHub repository, someone can use it to check if you have any Mainnet funds in that wallet address, and steal them!


## Fund the Deployer Address

Go to the [Hyperspace testnet faucet](https://hyperspace.yoga/#faucet), and paste in the Ethereum address from the previous step. This will send some hyperspace testnet FIL to the account.

## Deploy the Contracts

Currently there are 3 main types of contracts:

* Basic Solidity Examples: Simple contracts to show off basic solidity

* Filecoin API Examples: Contracts that demo how to use the Filecoin APIs in Solidity to access storage deals and other Filecoin specific functions.

* Basic Deal Client: A contract that demos how to create Filecoin storage deals within Solidity smart contracts. See below to learn more.


Type in the following command in the terminal to deploy a contract. Keep in mind that you can swap out the contract path and name for whichever one of your choosing:

```
forge build
forge create --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --contracts /src/SimpleCoin.sol SimpleCoin
```

This will deploy the SimpleCoin contract to the Hyperspace testnet. You can find the contract address in the terminal output:

```
Deployer: 0x42C930A33280a7218bc924732d67dd84D6247Af4
Deployed to: 0x859723aA05F8B0C10215C31E50d9647AD7c82C82
Transaction hash: 0x74071603994339f01b745e304c10f1bd97cfba4003d7a447977de1c89b478c7d
```

Now try doing the same with the Deal Client:

```
forge create --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --contracts src/client-contract/DealClient.sol DealClient
```

A common issue that you may see is a failure due to gas:

```
(code: 1, message: verify msg failed: message will not be included in a block: 'GasLimit' field cannot be less than the cost of storing a message on chain 152605 < 288863, data: None)
```

Simply pass in a higher gas limit to fix this (either via. a higher gas estimate multiplier or a fixed gas limit):

```
forge create --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --contracts src/client-contract/DealClient.sol DealClient -g 1000
```

## Interact with the Contracts

You can interact with contracts via forge scripts scripts, found in the 'scripts' folder. For example, to interact with the SimpleCoin contract:

Type in the following command in the terminal:

```
forge script script/SimpleCoin.s.sol:MyScript --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --broadcast --skip-simulation
```

You can also interact with contracts via the terminal/command line using the [Foundry cast tool](https://book.getfoundry.sh/cast/#overview-of-cast).

## Filecoin APIs

The primary advantage of the FEVM over other EVM based chains is the ability to access and program around Filecoin storage deals. This can be done in the FEVM via the [Filecoin.sol library maintained by Zondax](https://github.com/Zondax/filecoin-solidity). **Note this library is currently in BETA**. It is unaudited, and the APIs will likely be changing with time. This repo will be updated as soon as possible when a breaking change occurs.

The library is included in this kit as an NPM package and will automatically be downloaded when you perform the `yarn` command (don't confuse these with the included mocks)!

Currently you will find a getter contract that calls the getter methods on the MarketAPI to get storage deal data and store that data. To do this you will need *dealIDs* which you can [find here on FilFox](https://hyperspace.filfox.info/en/deal).

### Preparing Data for Storage

Before storing a file with a storage provider, it needs to be prepared by turning it into a .car file and the metadata must be recorded. To do this locally, you can use [this tool](https://github.com/filecoin-project/fevm-hardhat-kit/tree/main/tools), written in the language Go, which can do this for you. You can also use the [FVM Data Depot website](https://data.lighthouse.storage/) will automatically convert files to the .car format, output all the necessary metadata, and act as an HTTP retrieval point for the storage providers.

### Client Contract - Making Storage Deals in Solidity

Under contracts, within the `basic-deal-client` sub-directory, you will find a file called `DealClient.sol`. This is an example contract that uses the Filecoin.sol API's to create storage deals via Solidity smart contracts on Filecoin. This works by emitting a Solidity event that [Boost storage providers](https://boost.filecoin.io/) can listen to. To learn more about this contract feel free to [checkout the app kit repo](https://github.com/filecoin-project/fvm-starter-kit-deal-making) which includes a detailed readme and a frontend.

### Bounty Contract

Under contracts, within the `filecoin-api-examples` sub-directory, you will find a file called `deal-rewarder.sol`. This is a basic example contract that uses the Filecoin.sol API's to create bounties for specific data to be stored on the Filecoin blockchain. This is intended to be an example to illustrate how you can use the Filecoin APIs to do some cool functionality. To learn more about this contract feel free to [checkout the original Foundry project](https://github.com/lotus-web3/deal-bounty-contract) which includes a detailed readme.

