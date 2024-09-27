// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {King} from "../../src/puzzles/9/King.sol";
import {KingAttacker} from "../../src/attackers/9/KingAttacker.sol";

contract KingTest is Test {
    King internal puzzleContract;
    KingAttacker internal attackerContract;

    address owner = makeAddr("owner");
    address player = makeAddr("player");

    uint256 constant STARTING_USER_BALANCE = 100;
    uint256 constant STARTING_CONTRACT_BALANCE = 87;

    function setUp() public {
        vm.deal(owner, STARTING_USER_BALANCE);
        vm.deal(player, STARTING_USER_BALANCE);
        vm.startPrank(owner);
        puzzleContract = new King{value: STARTING_CONTRACT_BALANCE}();
        vm.stopPrank();
    }

    function testSolveKing() public {
        uint256 prize = puzzleContract.prize();
        assertEq(puzzleContract._king(), owner);
        assertEq(owner.balance, STARTING_USER_BALANCE - STARTING_CONTRACT_BALANCE);
        vm.startPrank(player);
        attackerContract = new KingAttacker();
        attackerContract.attack{value: prize}(address(puzzleContract));
        vm.stopPrank();
        assertEq(puzzleContract._king(), address(attackerContract));
        assertEq(owner.balance, STARTING_USER_BALANCE);

        vm.prank(owner);
        (bool success, ) = address(puzzleContract).call{value: prize + 1}("");
        assertEq(success, false);
    }
}