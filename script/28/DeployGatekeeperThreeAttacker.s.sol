// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {GatekeeperThreeAttacker} from "@attackers/28/GatekeeperThreeAttacker.sol";

contract DeployGatekeeperThreeAttacker is Script {
    function run(address target) external returns (GatekeeperThreeAttacker attacker) {
        vm.startBroadcast();
        attacker = new GatekeeperThreeAttacker(target);
        vm.stopBroadcast();
    }
}