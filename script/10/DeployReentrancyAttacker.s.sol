// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ReentrancyAttacker} from "@attackers/10/ReentrancyAttacker.sol";

contract DeployReentrancyAttacker is Script {
    function run(address target) external returns (ReentrancyAttacker attacker) {
        vm.startBroadcast();
        attacker = new ReentrancyAttacker(target);
        vm.stopBroadcast();
    }
}
