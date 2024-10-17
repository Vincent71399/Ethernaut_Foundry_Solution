// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {DexTwo, SwappableTokenTwo} from "../../src/puzzles/23/DexTwo.sol";

contract DexTwoTest is Test {
    DexTwo internal dex;
    SwappableTokenTwo internal token1;
    SwappableTokenTwo internal token2;

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
    }

    function testDexTwo() public view {
        console.log("Token1 balance in Dex: ", token1.balanceOf(address(dex)));
        console.log("Token2 balance in Dex: ", token2.balanceOf(address(dex)));
        console.log("Token1 balance in player: ", token1.balanceOf(player));
        console.log("Token2 balance in player: ", token2.balanceOf(player));
    }
}