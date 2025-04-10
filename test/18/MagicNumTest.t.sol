// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MagicNumAttacker} from "@attackers/18/MagicNumAttacker.sol";
import {MagicNum} from "@puzzles/18/MagicNum.sol";
import {MagicNumSolution} from "@script/18/MagicNumSolution.s.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

contract MagicNumTest is Test {
    MagicNum magicNum;
    MagicNumAttacker attacker;

    string public constant MAGIC_NUMBER_ATTACKER_LOCATION = "attackers/18/MagicNumAttacker";

    function setUp() public virtual {
        magicNum = new MagicNum();
        attacker = MagicNumAttacker(HuffDeployer.config().deploy(MAGIC_NUMBER_ATTACKER_LOCATION));
        magicNum.setSolver(address(attacker));
    }

    function testMagicNum() public view {
        assertEq(attacker.whatIsTheMeaningOfLife(), 42);
    }

    function testMagicNumSolution() public {
        MagicNumSolution solution = new MagicNumSolution();
        solution.solve(address(magicNum), address(attacker));
    }
}