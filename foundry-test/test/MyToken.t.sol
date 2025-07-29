// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MyToken.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyTokenTest is Test {
    MyToken public token;
    address public owner = address(1);
    address public user = address(2);

    function setUp() public {
        token = new MyToken();
        vm.prank(owner);
        token.transfer(user, 100 ether);
    }

    // Fuzz test: Ensure transfer doesn't exceed balance
    function testFuzzTransfer(uint256 amount) public {
        vm.assume(amount <= 100 ether); // Constrain fuzzer
        vm.prank(user);
        token.transfer(owner, amount);
        assertEq(token.balanceOf(owner), 900 ether + amount);
    }
}
