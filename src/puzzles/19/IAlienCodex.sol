// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IAlienCodex {
    function owner() external view returns (address);
    function contact() external view returns (bool);
    function makeContact() external;
    function record(bytes32 _content) external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}
