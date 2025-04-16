// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {GatekeeperThree, SimpleTrick} from "@puzzles/28/GatekeeperThree.sol";
import {GatekeeperThreeAttacker} from "@attackers/28/GatekeeperThreeAttacker.sol";
import {DeployGatekeeperThreeAttacker} from "@script/28/DeployGatekeeperThreeAttacker.s.sol";
import {GatekeeperThreeSolution} from "@script/28/GatekeeperThreeSolution.s.sol";

contract GatekeeperThreeTest is Test {
    GatekeeperThree internal gatekeeperThree;
    GatekeeperThreeAttacker internal attacker;

    address owner = makeAddr("owner");
    address player = msg.sender;

    function setUp() public {
        vm.startPrank(owner);
        gatekeeperThree = new GatekeeperThree();
        vm.stopPrank();

        attacker = new DeployGatekeeperThreeAttacker().run(address(gatekeeperThree));
        vm.deal(player, 0.002 ether);
    }

    function testGatekeeperThree() public {
        vm.startPrank(player);
        // bypass gateTwo
        gatekeeperThree.createTrick();
        SimpleTrick trick = gatekeeperThree.trick();
        uint256 password = uint256(vm.load(address(trick), bytes32(uint256(2)))); // read password from storage
        gatekeeperThree.getAllowance(password);
        // solve it
        payable(gatekeeperThree).transfer(0.001 ether + 1);
        attacker.attack();
        assertEq(gatekeeperThree.entrant(), player);
        vm.stopPrank();
    }

    function testGatekeeperThreeSolution() public {
        GatekeeperThreeSolution solution = new GatekeeperThreeSolution();
        solution.solve(address(attacker));
        assertEq(gatekeeperThree.entrant(), player);
    }
}