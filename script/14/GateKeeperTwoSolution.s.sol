// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperTwoAttacker} from "../../src/attackers/14/GatekeeperTwoAttacker.sol";

contract GateKeeperTwoSolution is Script {
    function run(address target) external {
        vm.startBroadcast();
        new GatekeeperTwoAttacker(target);
        vm.stopBroadcast();
    }
}