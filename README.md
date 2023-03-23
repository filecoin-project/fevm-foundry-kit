# FEVM Foundry Kit

This is a template for foundry that provides the basic scaffolding for quickly getting started with new projects. 

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

and then, do the following in the terminal:

```
source .env
```

If you use a .env file, don't commit and push any changes to .env files that may contain sensitive information, such as a private key! If this information reaches a public GitHub repository, someone can use it to check if you have any Mainnet funds in that wallet address, and steal them!


## Fund the Deployer Address

Go to the [Hyperspace testnet faucet](https://hyperspace.yoga/#faucet), and paste in the Ethereum address from the previous step. This will send some hyperspace testnet FIL to the account.


## Deploy the Contracts

Currently there are 2 main types of contracts:

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

Now try doing the smae with the Deal Client:

```
forge create --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --private-key $PRIVATE_KEY --contracts src/client-contract/DealClient.sol DealClient
```

## Interact with the Contracts

You can interact with contracts via forge scripts scripts, found in the 'scripts' folder. For example, to interact with the SimpleCoin contract:

Type in the following command in the terminal:

```
forge script script/SimpleCoin.s.sol:MyScript --rpc-url https://api.hyperspace.node.glif.io/rpc/v1 --broadcast --verify -vvvv
```

## Filecoin APIs

The primary advantage of the FEVM over other EVM based chains is the ability to access and program around Filecoin storage deals. This can be done in the FEVM via the [Filecoin.sol library maintained by Zondax](https://github.com/Zondax/filecoin-solidity). **Note this library is currently in BETA**. It is unaudited, and the APIs will likely be changing with time. This repo will be updated as soon as possible when a breaking change occurs.

The library is included in this kit as an NPM package and will automatically be downloaded when you perform the `yarn` command (don't confuse these with the included mocks)!

Currently you will find a getter contract that calls the getter methods on the MarketAPI to get storage deal data and store that data. To do this you will need *dealIDs* which you can [find here on FilFox](https://hyperspace.filfox.info/en/deal).

### Client Contract - Making Storage Deals in Solidity

Under contracts, within the `basic-deal-client` sub-directory, you will find a file called `DealClient.sol`. This is an example contract that uses the Filecoin.sol API's to create storage deals via Solidity smart contracts on Filecoin. This works by emitting a Solidity event that [Boost storage providers](https://boost.filecoin.io/) can listen to. To learn more about this contract feel free to [checkout the original Foundry project](https://github.com/lotus-web3/client-contract) which includes a detailed readme.

### Bounty Contract

Under contracts, within the `filecoin-api-examples` sub-directory, you will find a file called `deal-rewarder.sol`. This is a basic example contract that uses the Filecoin.sol API's to create bounties for specific data to be stored on the Filecoin blockchain. To learn more about this contract feel free to [checkout the original Foundry project](https://github.com/lotus-web3/deal-bounty-contract) which includes a detailed readme.

## What's Included

This template already contains submodules & remappings for `ds-test` (assertions for testing), `solmate` (building blocks for contracts) and `forge-std` (layer on top of hevm cheatcodes to improve UX).

Additionally, the testing folder contains `Console.sol` which allows you to console.log values (similar to JS and hardhat), `Hevm.sol` providing an interface to hevm cheatcodes, and `BaseTest.sol` which includes the two contracts above and `stdlib.sol` from `forge-std`. 

## Scripts

`Prettier` and `Solhint` can be run with the commands `yarn prettier` and `yarn solhint`. 

## Inspiration

Inspiration came from previous testing templates such as gakonst's [dapptools template](https://github.com/gakonst/dapptools-template), and current foundry templates by [Frankie](https://github.com/FrankieIsLost/forge-template) and [Abigger](https://github.com/abigger87/foundry-starter). 

