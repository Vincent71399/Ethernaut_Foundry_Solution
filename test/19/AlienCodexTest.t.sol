// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {LegacyDeployer} from "../LegacyDeployer.sol";
import {IAlienCodex} from "@puzzles/19/IAlienCodex.sol";

contract AlienCodexTest is Test, LegacyDeployer {
    IAlienCodex internal alienCodex;
    address internal attacker = makeAddr("attacker");

    function setUp() public {
        alienCodex = IAlienCodex(_deployPuzzle19());
    }

    function testAlienCodex() public {
        vm.startPrank(attacker);
        assertFalse(alienCodex.contact());
        alienCodex.makeContact();
        assertTrue(alienCodex.contact());
        vm.stopPrank();
    }
}