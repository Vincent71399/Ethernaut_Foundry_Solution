// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint256);

    function withdraw(uint256 _amount) external;
}
