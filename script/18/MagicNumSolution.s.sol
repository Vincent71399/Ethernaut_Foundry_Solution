// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MagicNum} from "../../src/puzzles/18/MagicNum.sol";
import {MagicNumAttacker} from "../../src/attackers/18/MagicNumAttacker.sol";

contract MagicNumSolution is Script {
    function run(address target, bytes memory bytecode) external {
        vm.startBroadcast();
        MagicNumAttacker attacker = MagicNumAttacker(deployContract(bytecode));
        require(attacker.whatIsTheMeaningOfLife() == 42);
        console.log("whatIsTheMeaningOfLife : ", attacker.whatIsTheMeaningOfLife());
        solve(target, address(attacker));
        vm.stopBroadcast();
    }

    function deployContract(bytes memory bytecode) internal returns (address deployed) {
        assembly {
            deployed := create(0, add(bytecode, 0x20), mload(bytecode))
        }
    }

    function solve(address target, address attacker) public {
        MagicNum magicNum = MagicNum(target);
        magicNum.setSolver(attacker);
    }
}
