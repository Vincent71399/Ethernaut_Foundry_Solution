// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {CoinFlip} from "@puzzles/3/CoinFlip.sol";
import {CoinFlipAttacker} from "@attackers/3/CoinFlipAttacker.sol";
import {CoinFlipSolution} from "@script/3/CoinFlipSolution.s.sol";
import {DeployCoinFlipAttacker} from "@script/3/DeployCoinFlipAttacker.s.sol";

contract CoinFlipTest is Test {
    CoinFlip internal puzzleContract;
    CoinFlipAttacker internal attacker;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() public {
        vm.startPrank(owner);
        puzzleContract = new CoinFlip();
        vm.stopPrank();

        attacker = new DeployCoinFlipAttacker().run(address(puzzleContract));
    }

    function testSolveCoinFlip() public {
        vm.startPrank(player);
        for (uint256 i = 0; i < 10; i++) {
            attacker.cheatGuess();
            uint256 newBlockNumber = block.number + 1;
            vm.roll(newBlockNumber);
        }
        vm.stopPrank();
        assertEq(puzzleContract.consecutiveWins(), 10);
    }

    function testCoinFlipSolution() public {
        CoinFlipSolution solution = new CoinFlipSolution();
        for (uint256 i = 0; i < 10; i++) {
            solution.solve(address(attacker));
            uint256 newBlockNumber = block.number + 1;
            vm.roll(newBlockNumber);
        }
        assertEq(puzzleContract.consecutiveWins(), 10);
    }
}
