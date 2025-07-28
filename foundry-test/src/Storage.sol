// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Storage {
    uint256 public number;

    function store(uint256 _number) public {
        number = _number;
    }

    function increment() public {
        number++;
    }
}