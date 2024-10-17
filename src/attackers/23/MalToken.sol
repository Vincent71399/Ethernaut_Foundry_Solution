// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin4.7.3/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin4.7.3/contracts/access/Ownable.sol";

contract MalToken is ERC20, Ownable {
    constructor() ERC20("MalToken", "MT") {}

    function mintTokensToAddress(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
    }

    function burnTokensFromAddress(address account, uint256 amount) external onlyOwner {
        _burn(account, amount);
    }
}
