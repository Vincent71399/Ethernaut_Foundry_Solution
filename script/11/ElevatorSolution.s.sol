// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {ElevatorAttacker} from "../../src/attackers/11/ElevatorAttacker.sol";

contract ElevatorSolution is Script {
    function run() external {
        address mostRecentlyDeployedElevatorAttacker =
            DevOpsTools.get_most_recent_deployment("ElevatorAttacker", block.chainid);
        solve(mostRecentlyDeployedElevatorAttacker);
    }

    function solve(address attacker) public {
        ElevatorAttacker elevatorAttacker = ElevatorAttacker(attacker);
        vm.startBroadcast();
        elevatorAttacker.attack();
        vm.stopBroadcast();
    }
}
