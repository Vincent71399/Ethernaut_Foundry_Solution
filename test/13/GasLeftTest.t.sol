// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {TestGasLeft} from "../../src/puzzles/13/TestGasLeft.sol";

contract GasLeftTest is Test {
    TestGasLeft internal puzzleContract;

    function setUp() public {
        puzzleContract = new TestGasLeft();
    }

    function testGasLeft() public {
        uint256 gasLeft = puzzleContract.testGasLeft{gas: 30000}(42);
        console.log("Gas left after testGasLeft(42):", gasLeft);
    }

    function testAnd() public view {
        uint256 result = puzzleContract.testAnd(0x0F, 0xF0);
        assertEq(result, 0x00);
        result = puzzleContract.testAnd(0x2F, 0xF0);
        assertEq(result, 0x20);
    }
}