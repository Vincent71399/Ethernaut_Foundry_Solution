// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Elevator} from "../../src/puzzles/11/Elevator.sol";
import {ElevatorAttacker} from "../../src/attackers/11/ElevatorAttacker.sol";
import {ElevatorSolution} from "../../script/11/ElevatorSolution.s.sol";
import {DeployElevatorAttacker} from "../../script/11/DeployElevatorAttacker.s.sol";

contract ElevatorTest is Test {
    Elevator internal puzzleContract;
    ElevatorAttacker internal attacker;

    function setUp() public {
        puzzleContract = new Elevator();
        attacker = new DeployElevatorAttacker().run(address(puzzleContract));
    }

    function testElevator() public {
        assertEq(puzzleContract.top(), false);
        attacker.attack();
        assertEq(puzzleContract.top(), true);
    }

    function testElevatorSolution() public {
        ElevatorSolution solution = new ElevatorSolution();
        solution.solve(address(attacker));
        assertEq(puzzleContract.top(), true);
    }
}
