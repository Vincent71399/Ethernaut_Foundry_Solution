// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {PreservationAttacker1, PreservationAttacker2} from "../../src/attackers/16/PreservationAttacker.sol";

contract DeployPreservationAttacker is Script {
    function run() external returns (PreservationAttacker1, PreservationAttacker2) {
        vm.startBroadcast();
        PreservationAttacker1 attacker1 = new PreservationAttacker1();
        PreservationAttacker2 attacker2 = new PreservationAttacker2();
        vm.stopBroadcast();

        return (attacker1, attacker2);
    }
}