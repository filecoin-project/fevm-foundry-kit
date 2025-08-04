// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "@forge-std/Script.sol";
import { console } from "forge-std/console.sol";

import "../src/basic-solidity-examples/SimpleCoin.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address yourAddress = vm.addr(deployerPrivateKey);
        console.log("Deployer address: ", yourAddress);
        vm.startBroadcast(deployerPrivateKey);

        SimpleCoin coin = new SimpleCoin();

        // Do whatever you want!

        vm.stopBroadcast();
    }
}
