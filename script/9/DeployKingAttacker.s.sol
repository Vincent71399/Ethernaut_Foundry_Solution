// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {KingAttacker} from "@attackers/9/KingAttacker.sol";

contract DeployKingAttacker is Script {
    function run() external returns (KingAttacker attacker) {
        vm.startBroadcast();
        attacker = new KingAttacker();
        vm.stopBroadcast();
    }
}
