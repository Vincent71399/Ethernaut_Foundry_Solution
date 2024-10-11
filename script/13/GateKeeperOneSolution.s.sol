// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {GatekeeperOneAttacker} from "../../src/attackers/13/GatekeeperOneAttacker.sol";

contract GateKeeperOneSolution is Script {
    function run() external {
        address mostRecentlyDeployedGatekeeperOneAttacker =
            DevOpsTools.get_most_recent_deployment("GatekeeperOneAttacker", block.chainid);
        console.log("GatekeeperOneAttacker address: ");
        console.logAddress(mostRecentlyDeployedGatekeeperOneAttacker);
        GatekeeperOneAttacker attacker = GatekeeperOneAttacker(mostRecentlyDeployedGatekeeperOneAttacker);

        vm.startBroadcast();
        attacker.attack();
        vm.stopBroadcast();
    }
}
