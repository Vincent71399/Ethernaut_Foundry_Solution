// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Denial} from "@puzzles/20/Denial.sol";
import {DenialAttacker} from "@attackers/20/DenialAttacker.sol";
import {DenialSolution} from "@script/20/DenialSolution.s.sol";

contract DenialTest is Test{
    Denial internal puzzleContract;
    address internal player = msg.sender;
    DenialAttacker internal attacker;

    uint256 internal constant DEFAULT_GAS_LIMIT = 1e6;

    function setUp() public {
        puzzleContract = new Denial();
        vm.deal(address(puzzleContract), 100 ether);
        attacker = new DenialAttacker(payable(puzzleContract));
        puzzleContract.setWithdrawPartner(address(attacker));
    }

    function testDenial() public {
        uint256 gasBefore = gasleft();

        bytes memory data = abi.encodeWithSelector(Denial.withdraw.selector);
        (bool success, ) = address(puzzleContract).call{gas: DEFAULT_GAS_LIMIT}(data);
        assertFalse(success);

        uint256 gasUsed = gasBefore - gasleft();
        console.log("Gas used: ", gasUsed);

        assertEq(puzzleContract.owner().balance, 0);
    }

    function testDenialSolution() public {
        DenialSolution solution = new DenialSolution();
        solution.solve(address(puzzleContract));

        bytes memory data = abi.encodeWithSelector(Denial.withdraw.selector);
        (bool success, ) = address(puzzleContract).call{gas: DEFAULT_GAS_LIMIT}(data);
        assertFalse(success);
        assertEq(puzzleContract.owner().balance, 0);
    }
}
