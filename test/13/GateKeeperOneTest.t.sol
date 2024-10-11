// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {GatekeeperOneAttacker} from "../../src/attackers/13/GatekeeperOneAttacker.sol";
import {GatekeeperOne} from "../../src/puzzles/13/GatekeeperOne.sol";
import {GateKeeperOneSolution} from "../../script/13/GateKeeperOneSolution.s.sol";
import {DeployGateKeeperOneAttacker} from "../../script/13/DeployGateKeeperOneAttacker.s.sol";

contract GateKeeperOneTest is Test {
    GatekeeperOne internal puzzleContract;

    address player = msg.sender;

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

    function testGateKeeperOneSolution() public {
        GatekeeperOneAttacker attacker = new DeployGateKeeperOneAttacker().run(address(puzzleContract));
        GateKeeperOneSolution solution = new GateKeeperOneSolution();
        solution.solve(address(attacker));
        assertEq(puzzleContract.entrant(), tx.origin);
    }
}
