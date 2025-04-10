// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {TelephoneAttacker} from "../../src/attackers/4/TelephoneAttacker.sol";

contract DeployTelephoneAttacker is Script {
    function run(address target) external returns (TelephoneAttacker attacker) {
        vm.startBroadcast();
        attacker = new TelephoneAttacker(target);
        vm.stopBroadcast();
    }
}
