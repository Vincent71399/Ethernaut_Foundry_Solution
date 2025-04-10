// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Shop, Buyer} from "@puzzles/21/Shop.sol";
import {ShopAttacker} from "@attackers/21/ShopAttacker.sol";
import {ShopSolution} from "@script/21/ShopSolution.s.sol";
import {DeployShopAttacker} from "@script/21/DeployShopAttacker.s.sol";

contract ShopTest is Test {
    Shop internal shop;

    address player = msg.sender;

    ShopAttacker internal attacker;

    function setUp() public {
        shop = new Shop();
        attacker = new DeployShopAttacker().run(address(shop));
    }

    function testShop() public {
        vm.startPrank(player);
        attacker.attack();
        assertEq(shop.price(), 0);
        vm.stopPrank();
    }

    function testShopSolution() public {
        ShopSolution solution = new ShopSolution();
        solution.solve(address(attacker));
        assertEq(shop.price(), 0);
    }
}