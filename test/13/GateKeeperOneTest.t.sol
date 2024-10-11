// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {GatekeeperOneAttacker} from "../../src/attackers/13/GatekeeperOneAttacker.sol";
import {GatekeeperOne} from "../../src/puzzles/13/GatekeeperOne.sol";
import {GateKeeperOneSolution} from "../../script/13/GateKeeperOneSolution.s.sol";
import {DeployGateKeeperOneAttacker} from "../../script/13/DeployGateKeeperOneAttacker.s.sol";

contract GateKeeperOneTest is Test {
    GatekeeperOne internal puzzleContract;
    GatekeeperOneAttacker internal attacker;

    address player = msg.sender;

    function setUp() public {
        puzzleContract = new GatekeeperOne();
        attacker = new DeployGateKeeperOneAttacker().run(address(puzzleContract));
    }

    function testGateKeeperOne() public {
        assertNotEq(puzzleContract.entrant(), player);

        attacker.attack();
        assertEq(puzzleContract.entrant(), tx.origin);
    }

    function testGateKeeperOneSolution() public {
        GateKeeperOneSolution solution = new GateKeeperOneSolution();
        solution.solve(address(attacker));
        assertEq(puzzleContract.entrant(), tx.origin);
    }
}
