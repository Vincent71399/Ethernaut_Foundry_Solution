// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {ShopAttacker} from "../../src/attackers/21/ShopAttacker.sol";

contract ShopSolution is Script {
    function run() external {
        address mostRecentlyDeployedShopAttacker = DevOpsTools.get_most_recent_deployment("ShopAttacker", block.chainid);
        solve(mostRecentlyDeployedShopAttacker);
    }

    function solve(address attacker) public {
        ShopAttacker shopAttacker = ShopAttacker(attacker);
        vm.broadcast();
        shopAttacker.attack();
    }
}
