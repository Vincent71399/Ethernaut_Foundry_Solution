// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {King} from "@puzzles/9/King.sol";
import {KingAttacker} from "@attackers/9/KingAttacker.sol";
import {KingSolution} from "@script/9/KingSolution.s.sol";
import {DeployKingAttacker} from "@script/9/DeployKingAttacker.s.sol";

contract KingTest is Test {
    King internal puzzleContract;
    KingAttacker internal attacker;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant STARTING_USER_BALANCE = 100;
    uint256 constant STARTING_CONTRACT_BALANCE = 87;

    function setUp() public {
        vm.deal(owner, STARTING_USER_BALANCE);
        vm.deal(player, STARTING_USER_BALANCE);
        vm.startPrank(owner);
        puzzleContract = new King{value: STARTING_CONTRACT_BALANCE}();
        vm.stopPrank();

        attacker = new DeployKingAttacker().run();
    }

    function testSolveKing() public {
        uint256 prize = puzzleContract.prize();
        assertEq(puzzleContract._king(), owner);
        assertEq(owner.balance, STARTING_USER_BALANCE - STARTING_CONTRACT_BALANCE);
        vm.startPrank(player);
        attacker.attack{value: prize}(address(puzzleContract));
        vm.stopPrank();
        assertEq(puzzleContract._king(), address(attacker));
        assertEq(owner.balance, STARTING_USER_BALANCE);

        vm.prank(owner);
        (bool success,) = address(puzzleContract).call{value: prize + 1}("");
        assertEq(success, false);
    }

    function testKingSolution() public {
        uint256 prize = puzzleContract.prize();

        KingSolution solution = new KingSolution();
        solution.solve(address(puzzleContract), address(attacker));

        assertEq(puzzleContract._king(), address(attacker));
        assertEq(owner.balance, STARTING_USER_BALANCE);

        vm.prank(owner);
        (bool success,) = address(puzzleContract).call{value: prize + 1}("");
        assertEq(success, false);
    }
}
