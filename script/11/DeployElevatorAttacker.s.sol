// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ElevatorAttacker} from "@attackers/11/ElevatorAttacker.sol";

contract DeployElevatorAttacker is Script {
    function run(address target) external returns (ElevatorAttacker attacker) {
        vm.startBroadcast();
        attacker = new ElevatorAttacker(target);
        vm.stopBroadcast();
    }
}
