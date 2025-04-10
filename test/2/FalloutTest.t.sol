// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {LegacyDeployer} from "../LegacyDeployer.sol";
import {IFallout} from "@puzzles/2/IFallout.sol";
import {FalloutSolution} from "@script/2/FalloutSolution.s.sol";

contract FalloutTest is Test, LegacyDeployer {
    IFallout internal puzzleContract;

    address owner = makeAddr("owner");
    address player = msg.sender;

    function setUp() public {
        vm.startPrank(owner);
        puzzleContract = IFallout(_deployPuzzle2());
        vm.stopPrank();
    }

    function testSolveFallout() public {
        vm.startPrank(player);
        puzzleContract.Fal1out();
        assertEq(puzzleContract.owner(), player);
        vm.stopPrank();
    }

    function testFalloutSolution() public {
        FalloutSolution solution = new FalloutSolution();
        solution.run(address(puzzleContract));
        assertEq(puzzleContract.owner(), player);
    }
}
