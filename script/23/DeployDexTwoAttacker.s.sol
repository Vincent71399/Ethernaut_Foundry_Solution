// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {MalToken} from "@attackers/23/MalToken.sol";

contract DeployDexTwoAttacker is Script {
    function run() external returns (MalToken attacker) {
        vm.startBroadcast();
        attacker = new MalToken();
        vm.stopBroadcast();
    }
}