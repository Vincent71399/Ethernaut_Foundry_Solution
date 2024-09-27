// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Vault} from "../../src/puzzles/8/Vault.sol";

contract VaultTest is Test {
    Vault internal puzzleContract;

    bytes32 secret = bytes32(uint256(166));

    function setUp() public {
        puzzleContract = new Vault(secret);
    }

    function testSolveVault() public view {
        bytes32 slot1 = vm.load(address(puzzleContract), bytes32(uint256(1)));
        console.log("Slot 1: ", uint256(slot1));
        assertEq(slot1, secret);
    }
}