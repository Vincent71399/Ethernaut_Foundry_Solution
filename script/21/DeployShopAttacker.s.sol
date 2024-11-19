// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ShopAttacker} from "../../src/attackers/21/ShopAttacker.sol";

contract DeployShopAttacker is Script {
    function run(address target) external returns (ShopAttacker) {
        vm.startBroadcast();
        ShopAttacker attacker = new ShopAttacker(target);
        vm.stopBroadcast();
        return (attacker);
    }
}