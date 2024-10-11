// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperTwo} from "../../src/puzzles/14/GatekeeperTwo.sol";
import {GatekeeperTwoAttacker} from "../../src/attackers/14/GatekeeperTwoAttacker.sol";
import {GateKeeperTwoSolution} from "../../script/14/GateKeeperTwoSolution.s.sol";

contract GateKeeperTwoTest is Test {
    GatekeeperTwo internal puzzleContract;

    function setUp() public {
        puzzleContract = new GatekeeperTwo();
    }

    function testGateKeeperTwo() public {
        assertNotEq(puzzleContract.entrant(), tx.origin);
        new GatekeeperTwoAttacker(address(puzzleContract));
        assertEq(puzzleContract.entrant(), tx.origin);
    }

    function testGateKeeperTwoSolution() public {
        assertNotEq(puzzleContract.entrant(), tx.origin);
        GateKeeperTwoSolution solution = new GateKeeperTwoSolution();
        solution.run(address(puzzleContract));
        assertEq(puzzleContract.entrant(), tx.origin);
    }
}
