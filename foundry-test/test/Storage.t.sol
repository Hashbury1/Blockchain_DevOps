// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Storage.sol";

contract StorageTest is Test {
    Storage public storageContract;

    function setUp() public {
        storageContract = new Storage();
    }

    // Unit test
    function testStore() public {
        storageContract.store(100);
        assertEq(storageContract.number(), 100);
    }

    // Unit test with assertion helpers
    function testIncrement() public {
        storageContract.store(10);
        storageContract.increment();
        assertEq(storageContract.number(), 11, "Number should increment");
        assertGt(storageContract.number(), 10);
    }

    // Fuzz test (random inputs)
    function testFuzzStore(uint256 x) public {
        storageContract.store(x);
        assertEq(storageContract.number(), x);
    }
}
