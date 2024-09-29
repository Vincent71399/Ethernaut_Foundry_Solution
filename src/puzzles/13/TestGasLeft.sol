// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract TestGasLeft {
    uint256 public x;

    function testGasLeft(uint256 input) public returns(uint256) {
        x = input;
        return gasleft();
    }

    function testAnd(uint256 a, uint256 b) public pure returns(uint256) {
        return a & b;
    }
}
