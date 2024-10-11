// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {NaughtCoin} from "../../src/puzzles/15/NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin internal puzzleContract;

    address player = makeAddr("player");

    function setUp() public {
        vm.prank(player);
        puzzleContract = new NaughtCoin(player);
    }

    function testNaughtCoin() public {
        uint256 playerBalance = puzzleContract.balanceOf(player);
        console.log("Player balance: %d", playerBalance);

        vm.startPrank(player);
        puzzleContract.approve(player, playerBalance);
        puzzleContract.transferFrom(player, address(this), playerBalance);
        vm.stopPrank();

        playerBalance = puzzleContract.balanceOf(player);
        console.log("Player balance: %d", playerBalance);

        assertEq(playerBalance, 0);
    }
}
