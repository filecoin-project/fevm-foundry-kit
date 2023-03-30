// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "@forge-std/Script.sol";
import "../src/filecoin-api-examples/DealRewarder.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DealRewarder deal_rewarder = new DealRewarder(); // Put valid address here

        payable(address(deal_rewarder)).transfer(1 ether);

        bytes memory cidBytes = vm.envBytes("CID_BYTES"); // Hex Bytes of CID
        uint256 dataSize = vm.envUint("DATA_SIZE");

        deal_rewarder.addCID(cidBytes, dataSize);

        uint64 dealID = uint64(vm.envUint("DEAL_ID")); // Pass the DEAL_ID in as an environment variable
        deal_rewarder.claim_bounty(dealID);

        vm.stopBroadcast();
    }
}