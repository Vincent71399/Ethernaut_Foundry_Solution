// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "../../src/puzzles/4/Telephone.sol";
import {TelephoneAttacker} from "../../src/attackers/4/TelephoneAttacker.sol";
import {TelephoneSolution} from "../../script/4/TelephoneSolution.s.sol";
import {DeployTelephoneAttacker} from "../../script/4/DeployTelephoneAttacker.s.sol";

contract TelephoneTest is Test {
    Telephone internal puzzleContract;

    address owner = makeAddr("owner");
    address player = msg.sender;

    function setUp() public {
        vm.startPrank(owner);
        puzzleContract = new Telephone();
        vm.stopPrank();
    }

    function testSolveTelephone() public {
        vm.startPrank(player);
        TelephoneAttacker attacker = new TelephoneAttacker(address(puzzleContract));
        attacker.attack();
        vm.stopPrank();
        assertEq(puzzleContract.owner(), player);
    }

    function testTelephoneSolution() public {
        TelephoneAttacker attacker = new DeployTelephoneAttacker().run(address(puzzleContract));
        TelephoneSolution solution = new TelephoneSolution();
        solution.solve(address(attacker));
        assertEq(puzzleContract.owner(), player);
    }
}
