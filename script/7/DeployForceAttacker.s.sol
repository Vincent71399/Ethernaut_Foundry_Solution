// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {ForceAttacker} from "../../src/attackers/7/ForceAttacker.sol";

contract DeployForceAttacker is Script {
    function run() external returns (ForceAttacker) {
        vm.startBroadcast();
        ForceAttacker attacker = new ForceAttacker();
        vm.stopBroadcast();
        return attacker;
    }
}
