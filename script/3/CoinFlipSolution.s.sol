// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { DevOpsTools } from "foundry-devops/src/DevOpsTools.sol";
import { CoinFlipAttacker } from "../../src/attackers/3/CoinFlipAttacker.sol";

contract CoinFlipSolution is Script {
    function run() public {
        address mostRecentlyDeployedCoinFlipAttacker = DevOpsTools.get_most_recent_deployment("CoinFlipAttacker", block.chainid);
        console.log("CoinFlipAttacker address: ");
        console.logAddress(mostRecentlyDeployedCoinFlipAttacker);
        solve(mostRecentlyDeployedCoinFlipAttacker);
    }

    function solve(address attacker) public {
        CoinFlipAttacker coinFlipAttacker = CoinFlipAttacker(attacker);
        vm.startBroadcast();
        coinFlipAttacker.cheatGuess();
        vm.stopBroadcast();
    }
}
