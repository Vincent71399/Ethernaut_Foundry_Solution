// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {ElevatorAttacker} from "../../src/attackers/11/ElevatorAttacker.sol";

contract ElevatorSolution is Script {
    function run() external {
        address mostRecentlyDeployedElevatorAttacker = DevOpsTools.get_most_recent_deployment("ElevatorAttacker", block.chainid);
        console.log("KingAttacker address: ");
        console.logAddress(mostRecentlyDeployedElevatorAttacker);
        ElevatorAttacker attacker = ElevatorAttacker(mostRecentlyDeployedElevatorAttacker);

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();
    }
}