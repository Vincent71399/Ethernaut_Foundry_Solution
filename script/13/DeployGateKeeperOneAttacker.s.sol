// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperOneAttacker} from "../../src/attackers/13/GatekeeperOneAttacker.sol";

contract DeployGateKeeperOneAttacker is Script {
    function run(address target) external returns (GatekeeperOneAttacker attacker) {
        vm.startBroadcast();
        attacker = new GatekeeperOneAttacker(target);
        vm.stopBroadcast();
    }
}
