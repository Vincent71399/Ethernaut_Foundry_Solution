// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IFallout {
    function owner() external view returns (address);
    function Fal1out() external payable;
    function allocate() external payable;
    function sendAllocation(address allocator) external;
    function collectAllocations() external;
    function allocatorBalance(address allocator) external view returns (uint256);
}
