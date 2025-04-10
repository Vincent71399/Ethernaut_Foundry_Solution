// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ShopAttacker} from "@attackers/21/ShopAttacker.sol";

contract DeployShopAttacker is Script {
    function run(address target) external returns (ShopAttacker attacker) {
        vm.startBroadcast();
        attacker = new ShopAttacker(target);
        vm.stopBroadcast();
    }
}