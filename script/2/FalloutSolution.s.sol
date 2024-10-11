// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallout} from "@puzzles/2/Fallout.sol";

contract FalloutSolution is Script {
    function run(address target) public {
        Fallout puzzleContract = Fallout(target);

        vm.startBroadcast();
        puzzleContract.Fal1out();
        vm.stopBroadcast();
    }
}
