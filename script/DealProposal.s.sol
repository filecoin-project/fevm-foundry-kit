// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "@forge-std/Script.sol";
import "../src/basic-deal-client/DealClient.sol";

contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        ExtraParamsV1 memory extraParamsV1 = ExtraParamsV1({
            location_ref: vm.envString("LOCATION_REF"),
            car_size: uint64(vm.envUint("CAR_SIZE")),
            skip_ipni_announce: false,
            remove_unsealed_copy: false
        });
        // Replace this with whatever you'd like
        DealRequest memory dealRequest = DealRequest({
            piece_cid: vm.envBytes("PIECE_CID_BYTES"),
            piece_size: uint64(vm.envUint("PIECE_SIZE")),
            verified_deal: false,
            label: vm.envString("commP"),
            start_epoch: 520000,
            end_epoch: 1555200,
            storage_price_per_epoch: 0,
            provider_collateral: 0,
            client_collateral: 0,
            extra_params_version: 1,
            extra_params: extraParamsV1
        });
        vm.startBroadcast(deployerPrivateKey);

        DealClient deal_client = new DealClient(); // Put valid address here

        deal_client.makeDealProposal(dealRequest);

        // Use the following to get your deal proposal from dealID
        // uint256 dealID = vm.envUint("DEAL_ID"); // Pass the DEAL_ID in as an environment variable
        // deal_client.getDealProposal(dealID);

        vm.stopBroadcast();
    }
}