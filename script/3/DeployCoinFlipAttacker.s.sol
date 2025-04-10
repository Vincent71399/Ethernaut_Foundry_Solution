// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {CoinFlipAttacker} from "@attackers/3/CoinFlipAttacker.sol";

contract DeployCoinFlipAttacker is Script {
    function run(address target) external returns (CoinFlipAttacker attacker) {
        vm.startBroadcast();
        attacker = new CoinFlipAttacker(target);
        vm.stopBroadcast();
    }
}
