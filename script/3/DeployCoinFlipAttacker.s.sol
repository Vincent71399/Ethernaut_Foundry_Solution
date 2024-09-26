// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlipAttacker} from "../../src/attackers/3/CoinFlipAttacker.sol";

contract DeployCoinFlipAttacker is Script {
    function run(address target) external returns (CoinFlipAttacker) {
        vm.startBroadcast();
        CoinFlipAttacker attacker = new CoinFlipAttacker(target);
        vm.stopBroadcast();
        return attacker;
    }
}