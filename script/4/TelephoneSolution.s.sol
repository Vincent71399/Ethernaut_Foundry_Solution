// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {TelephoneAttacker} from "@attackers/4/TelephoneAttacker.sol";

contract TelephoneSolution is Script {
    function run() public {
        address mostRecentlyDeployedTelephoneAttacker =
            DevOpsTools.get_most_recent_deployment("TelephoneAttacker", block.chainid);
        solve(mostRecentlyDeployedTelephoneAttacker);
    }

    function solve(address attacker) public {
        TelephoneAttacker telephoneAttacker = TelephoneAttacker(attacker);
        vm.startBroadcast();
        telephoneAttacker.attack();
        vm.stopBroadcast();
    }
}
