// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {KingAttacker} from "../../src/attackers/9/KingAttacker.sol";

contract DeployKingAttacker is Script {
    function run() external returns (KingAttacker) {
        vm.startBroadcast();
        KingAttacker attacker = new KingAttacker();
        vm.stopBroadcast();
        return attacker;
    }
}
