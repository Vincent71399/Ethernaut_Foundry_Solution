// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Force} from "@puzzles/7/Force.sol";
import {ForceAttacker} from "@attackers/7/ForceAttacker.sol";
import {ForceSolution} from "@script/7/ForceSolution.s.sol";
import {DeployForceAttacker} from "@script/7/DeployForceAttacker.s.sol";

contract ForceTest is Test {
    Force internal puzzleContract;
    ForceAttacker internal attacker;

    uint256 constant VALUE_TO_SEND = 1;

    function setUp() public {
        puzzleContract = new Force();
        attacker = new DeployForceAttacker().run();
    }

    function testForce() public {
        assertEq(address(puzzleContract).balance, 0);
        attacker.attack{value: VALUE_TO_SEND}(address(puzzleContract));
        assertEq(address(puzzleContract).balance, VALUE_TO_SEND);
    }

    function testForceSolution() public {
        ForceSolution solution = new ForceSolution();
        solution.solve(address(puzzleContract), address(attacker));
        assertEq(address(puzzleContract).balance, VALUE_TO_SEND);
    }
}
