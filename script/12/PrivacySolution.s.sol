// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Privacy} from "../../src/puzzles/12/Privacy.sol";

contract PrivacySolution is Script {
    function run(address target, bytes32 key32) external {
        Privacy puzzleContract = Privacy(target);
        vm.startBroadcast();
        puzzleContract.unlock(bytes16(key32));
        vm.stopBroadcast();
        console.log("Locked: ", puzzleContract.locked());
    }
}