// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperOne} from "../../src/puzzles/13/GatekeeperOne.sol";
import {GatekeeperOneAttacker} from "../../src/attackers/13/GatekeeperOneAttacker.sol";

contract GateKeeperOneTest is Test {
    GatekeeperOne internal puzzleContract;

    address player = makeAddr("player");

    function setUp() public {
        puzzleContract = new GatekeeperOne();
    }

    function testGateKeeperOne() public {
        assertNotEq(puzzleContract.entrant(), player);

        GatekeeperOneAttacker attackerContract = new GatekeeperOneAttacker(address(puzzleContract));
        attackerContract.attack();
        assertEq(puzzleContract.entrant(), tx.origin);
        console.log("iteration: ", attackerContract.iteration());
    }
}