// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import { DSTest } from "@ds-test/test.sol";
import "../utils/Hevm.sol";
import { console } from "@forge-std/console.sol";
import { StdCheatsSafe } from "@forge-std/StdCheats.sol";
import { StdStorage, stdStorageSafe } from "@forge-std/StdStorage.sol";

contract BaseTest is DSTest, StdCheatsSafe {
    using stdStorageSafe for StdStorage;

    StdStorage stdstore;
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);
}
