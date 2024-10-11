// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;
// fix for legacy version of test
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {Reentrance} from "../../src/puzzles/10/Reentrance.sol";
import {ReentrancyAttacker} from "../../src/attackers/10/ReentrancyAttacker.sol";
import {ReentrancySolution} from "../../script/10/ReentrancySolution.s.sol";
import {DeployReentrancyAttacker} from "../../script/10/DeployReentrancyAttacker.s.sol";

contract ReentranceTest is Test {
    Reentrance internal puzzleContract;
    ReentrancyAttacker internal attacker;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant STARTING_USER_BALANCE = 100 ether;
    uint256 constant STARTING_CONTRACT_BALANCE = 10 ether;

    function setUp() public {
        vm.deal(owner, STARTING_USER_BALANCE);
        vm.deal(player, STARTING_USER_BALANCE);

        vm.startPrank(owner);
        puzzleContract = new Reentrance();
        puzzleContract.donate{value: STARTING_CONTRACT_BALANCE}(owner);
        vm.stopPrank();

        attacker = new DeployReentrancyAttacker().run(address(puzzleContract));
    }

    function testSolveReentrance() public {
        console.log("Puzzle contract balance: ", address(puzzleContract).balance);
        assertEq(address(puzzleContract).balance, STARTING_CONTRACT_BALANCE);
        vm.startPrank(player);
        attacker.attack{value: 1e17}();
        assertEq(address(puzzleContract).balance, 0);
        console.log("Puzzle contract balance: ", address(puzzleContract).balance);
        attacker.withdraw();
        assertEq(player.balance, STARTING_USER_BALANCE + STARTING_CONTRACT_BALANCE);
        vm.stopPrank();
    }

    function testReentrancySolution() public {
        ReentrancySolution solution = new ReentrancySolution();
        solution.run(address(attacker));

        assertEq(address(puzzleContract).balance, 0);
        assertEq(player.balance, STARTING_USER_BALANCE + STARTING_CONTRACT_BALANCE);
    }
}
