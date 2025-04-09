// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IFallout} from "@puzzles/2/IFallout.sol";
import {LegacyDeployer} from "test/LegacyDeployer.sol";

contract FalloutSolution is Script, LegacyDeployer {
    function run(address target) public {
        IFallout puzzleContract = IFallout(target);

        vm.startBroadcast();
        puzzleContract.Fal1out();
        vm.stopBroadcast();
    }
}
