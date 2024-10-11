// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {TelephoneAttacker} from "../../src/attackers/4/TelephoneAttacker.sol";

contract DeployTelephoneAttacker is Script {
    function run(address target) external returns (TelephoneAttacker) {
        vm.startBroadcast();
        TelephoneAttacker attacker = new TelephoneAttacker(target);
        vm.stopBroadcast();
        return attacker;
    }
}
