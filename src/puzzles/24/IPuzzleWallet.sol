// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPuzzleWallet {
    // public variables
    function owner() external view returns (address);
    function maxBalance() external view returns (uint256);
    function whitelisted(address addr) external view returns (bool);
    function balances(address addr) external view returns (uint256);
    // function
    function init(uint256 _maxBalance) external;
    function setMaxBalance(uint256 _maxBalance) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function execute(address to, uint256 value, bytes calldata data) external;
    function multicall(bytes[] calldata data) external payable;
}