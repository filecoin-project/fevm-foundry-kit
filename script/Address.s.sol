// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "@forge-std/Script.sol";

contract MyScript is Script {
    function run() external {
        // Run this script to get your address
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        address yourAddress = vm.addr(deployerPrivateKey);

        console.log(yourAddress);
    }
}