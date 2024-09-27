// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Force} from "../../src/puzzles/7/Force.sol";
import {ForceAttacker} from "../../src/attackers/7/ForceAttacker.sol";

contract ForceTest is Test {
    Force internal puzzleContract;
    ForceAttacker internal attackerContract;

    uint256 constant VALUE_TO_SEND = 1;

    function setUp() public {
        puzzleContract = new Force();
        attackerContract = new ForceAttacker();
    }

    function testForce() public {
        assertEq(address(puzzleContract).balance, 0);
        attackerContract.attack{value: VALUE_TO_SEND}(address(puzzleContract));
        assertEq(address(puzzleContract).balance, VALUE_TO_SEND);
    }
}