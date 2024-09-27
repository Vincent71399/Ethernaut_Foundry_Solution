// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Elevator} from "../../src/puzzles/11/Elevator.sol";
import {ElevatorAttacker} from "../../src/attackers/11/ElevatorAttacker.sol";

contract ElevatorTest is Test {
    Elevator internal puzzleContract;
    ElevatorAttacker internal attackerContract;

    function setUp() public {
        puzzleContract = new Elevator();
        attackerContract = new ElevatorAttacker(address(puzzleContract));
    }

    function testElevator() public {
        assertEq(puzzleContract.top(), false);
        attackerContract.attack();
        assertEq(puzzleContract.top(), true);
    }
}