// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
// fix for legacy version of test
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Reentrance} from "../src/puzzles/10/Reentrance.sol";
import {ReentrancyAttacker} from "../src/attackers/10/ReentrancyAttacker.sol";

contract ReentranceTest is Test {
    Reentrance internal puzzleContract;
    ReentrancyAttacker internal attackerContract;

    address owner = makeAddr("owner");
    address player = makeAddr("player");

    uint256 constant STARTING_USER_BALANCE = 100 ether;
    uint256 constant STARTING_CONTRACT_BALANCE = 10 ether;

    function setUp() public {
        vm.deal(owner, STARTING_USER_BALANCE);
        vm.deal(player, STARTING_USER_BALANCE);

        vm.startPrank(owner);
        puzzleContract = new Reentrance();
        puzzleContract.donate{value: STARTING_CONTRACT_BALANCE}(owner);
        vm.stopPrank();

        vm.startPrank(player);
        attackerContract = new ReentrancyAttacker(address(puzzleContract));
        vm.stopPrank();
    }

    function testSolveReentrance() public {
        console.log("Puzzle contract balance: ", address(puzzleContract).balance);
        assertEq(address(puzzleContract).balance, STARTING_CONTRACT_BALANCE);
        vm.startPrank(player);
        attackerContract.attack{value: 1e17}();
        assertEq(address(puzzleContract).balance, 0);
        console.log("Puzzle contract balance: ", address(puzzleContract).balance);
        attackerContract.withdraw();
        assertEq(player.balance, STARTING_USER_BALANCE + STARTING_CONTRACT_BALANCE);
        vm.stopPrank();
    }
}
