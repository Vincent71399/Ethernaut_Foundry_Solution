// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { TelephoneAttacker } from "../../src/attackers/4/TelephoneAttacker.sol";

contract TelephoneSolution is Script {
    function run() public {
        address mostRecentlyDeployedTelephoneAttacker = DevOpsTools.get_most_recent_deployment("TelephoneAttacker", block.chainid);
        console.log("TelephoneAttacker address: ");
        console.logAddress(mostRecentlyDeployedTelephoneAttacker);
        TelephoneAttacker telephoneAttacker = TelephoneAttacker(mostRecentlyDeployedTelephoneAttacker);
        vm.startBroadcast();
        telephoneAttacker.attack();
        vm.stopBroadcast();
    }
}