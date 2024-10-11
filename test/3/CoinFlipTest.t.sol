// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {CoinFlip} from "../../src/puzzles/3/CoinFlip.sol";
import {CoinFlipAttacker} from "../../src/attackers/3/CoinFlipAttacker.sol";
import {CoinFlipSolution} from "../../script/3/CoinFlipSolution.s.sol";
import {DeployCoinFlipAttacker} from "../../script/3/DeployCoinFlipAttacker.s.sol";

contract CoinFlipTest is Test {
    CoinFlip internal puzzleContract;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() public {
        vm.startPrank(owner);
        puzzleContract = new CoinFlip();
        vm.stopPrank();
    }

    function testSolveCoinFlip() public {
        vm.startPrank(player);
        CoinFlipAttacker attacker = new CoinFlipAttacker(address(puzzleContract));
        for (uint256 i = 0; i < 10; i++) {
            attacker.cheatGuess();
            console.log("Win count: ", puzzleContract.consecutiveWins());
            console.log("Block number: ", block.number);
            uint256 newBlockNumber = block.number + 1;
            vm.roll(newBlockNumber);
        }
        vm.stopPrank();
        assertEq(puzzleContract.consecutiveWins(), 10);
    }

    function testCoinFlipSolution() public {
        CoinFlipAttacker attacker = new DeployCoinFlipAttacker().run(address(puzzleContract));
        CoinFlipSolution solution = new CoinFlipSolution();
        for (uint256 i = 0; i < 10; i++) {
            solution.solve(address(attacker));
            uint256 newBlockNumber = block.number + 1;
            vm.roll(newBlockNumber);
        }
        assertEq(puzzleContract.consecutiveWins(), 10);
    }
}
