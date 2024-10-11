// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Vault} from "../../src/puzzles/8/Vault.sol";

contract VaultSolution is Script {
    function run(address target, bytes32 password) public {
        Vault puzzleContract = Vault(target);
        vm.startBroadcast();
        puzzleContract.unlock(password);
        vm.stopBroadcast();
    }
}
