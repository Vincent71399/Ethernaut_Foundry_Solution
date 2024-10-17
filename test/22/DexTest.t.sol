// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Dex, SwappableToken} from "../../src/puzzles/22/Dex.sol";
import {DexSolution} from "../../script/22/DexSolution.s.sol";

contract DexTest is Test {
    Dex internal dex;
    SwappableToken internal token1;
    SwappableToken internal token2;

    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant INITIAL_SUPPLY = 110;
    uint256 constant INITIAL_POOL_BALANCE = 100;
    uint256 constant INITIAL_USER_BALANCE = 10;

    function setUp() public {
        vm.startPrank(owner);
        dex = new Dex();
        token1 = new SwappableToken(address(dex), "Token1", "T1", INITIAL_SUPPLY);
        token2 = new SwappableToken(address(dex), "Token2", "T2", INITIAL_SUPPLY);
        dex.setTokens(address(token1), address(token2));
        token1.transfer(address(dex), INITIAL_POOL_BALANCE);
        token2.transfer(address(dex), INITIAL_POOL_BALANCE);
        token1.transfer(player, INITIAL_USER_BALANCE);
        token2.transfer(player, INITIAL_USER_BALANCE);
        vm.stopPrank();
    }

    function swapAll() internal {
        uint256 playerBalance1 = token1.balanceOf(player);
        uint256 playerBalance2 = token2.balanceOf(player);

        SwappableToken tokenFrom;
        SwappableToken tokenTo;
        uint256 swapAmount;

        if(playerBalance1 >= playerBalance2){
            tokenFrom = token1;
            tokenTo = token2;
            swapAmount = playerBalance1;
        }else{
            tokenFrom = token2;
            tokenTo = token1;
            swapAmount = playerBalance2;
        }
        uint256 remainBalance = tokenTo.balanceOf(address(dex));
        uint256 maxSwapAmount = dex.getSwapPrice(address(tokenTo), address(tokenFrom), remainBalance);

        if(swapAmount > maxSwapAmount){
            swapAmount = maxSwapAmount;
        }

        vm.startPrank(player);
        tokenFrom.approve(address(dex), swapAmount);
        dex.swap(address(tokenFrom), address(tokenTo), swapAmount);
        vm.stopPrank();
    }

    function testDex() public {
        while(token1.balanceOf(address(dex)) > 0 && token2.balanceOf(address(dex)) > 0){
            swapAll();
        }

        assert(token1.balanceOf(address(dex)) == 0 || token2.balanceOf(address(dex)) == 0);
    }

    function testDexSolution() public {
        DexSolution solution = new DexSolution();
        solution.solve(address(dex), player);

        assert(token1.balanceOf(address(dex)) == 0 || token2.balanceOf(address(dex)) == 0);
    }
}