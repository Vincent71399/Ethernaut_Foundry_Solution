// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Privacy} from "../../src/puzzles/12/Privacy.sol";

contract PrivacyTest is Test {
    Privacy internal puzzleContract;
    bytes32[3] private data;

    function setUp() public {
        data[0] = bytes32(keccak256("data1"));
        data[1] = bytes32(keccak256("data2"));
        data[2] = bytes32(keccak256("data3"));

        puzzleContract = new Privacy(data);
    }

    function testPrivacy() public {
        bytes32 slot5 = vm.load(address(puzzleContract), bytes32(uint256(5)));
        assertEq(slot5, data[2]);
        puzzleContract.unlock(bytes16(slot5));
        assertEq(puzzleContract.locked(), false);
    }
}