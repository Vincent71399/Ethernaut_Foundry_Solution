// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {LegacyDeployer} from "../LegacyDeployer.sol";
import {IReentrance} from "@puzzles/10/IReentrance.sol";
import {ReentrancyAttacker} from "@attackers/10/ReentrancyAttacker.sol";
import {ReentrancySolution} from "@script/10/ReentrancySolution.s.sol";
import {DeployReentrancyAttacker} from "@script/10/DeployReentrancyAttacker.s.sol";

contract ReentranceTest is Test, LegacyDeployer {
    IReentrance internal puzzleContract;
    ReentrancyAttacker internal attacker;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant STARTING_USER_BALANCE = 100 ether;
    uint256 constant STARTING_CONTRACT_BALANCE = 10 ether;

    function setUp() public {
        vm.deal(owner, STARTING_USER_BALANCE);
        vm.deal(player, STARTING_USER_BALANCE);

        vm.startPrank(owner);
        puzzleContract = IReentrance(_deployPuzzle10());
        puzzleContract.donate{value: STARTING_CONTRACT_BALANCE}(owner);
        vm.stopPrank();

        attacker = new DeployReentrancyAttacker().run(address(puzzleContract));
    }

    function testSolveReentrance() public {
        assertEq(address(puzzleContract).balance, STARTING_CONTRACT_BALANCE);
        vm.startPrank(player);
        attacker.attack{value: 1e17}();
        assertEq(address(puzzleContract).balance, 0);
        attacker.withdraw();
        assertEq(player.balance, STARTING_USER_BALANCE + STARTING_CONTRACT_BALANCE);
        vm.stopPrank();
    }

    function testReentrancySolution() public {
        ReentrancySolution solution = new ReentrancySolution();
        solution.solve(address(attacker));

        assertEq(address(puzzleContract).balance, 0);
        assertEq(player.balance, STARTING_USER_BALANCE + STARTING_CONTRACT_BALANCE);
    }
}
