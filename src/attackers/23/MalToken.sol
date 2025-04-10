// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import {Ownable} from "openzeppelin-contracts-08/access/Ownable.sol";

contract MalToken is ERC20, Ownable {
    constructor() ERC20("MalToken", "MT") {}

    function mintTokensToAddress(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
    }

    function burnTokensFromAddress(address account, uint256 amount) external onlyOwner {
        _burn(account, amount);
    }
}
