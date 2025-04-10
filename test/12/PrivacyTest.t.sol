// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Privacy} from "@puzzles/12/Privacy.sol";
import {PrivacySolution} from "@script/12/PrivacySolution.s.sol";

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

    function testPrivacySolution() public {
        bytes32 slot5 = vm.load(address(puzzleContract), bytes32(uint256(5)));
        PrivacySolution solution = new PrivacySolution();
        solution.run(address(puzzleContract), slot5);
        assertEq(puzzleContract.locked(), false);
    }
}
