// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */

contract Fund22 {
    // using SafeMath for uint256;
    mapping(address => uint256) private _deposits;
    event Deposited(address indexed payee, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);

    constructor() {
    }

    function withdraw(uint amount) public payable {
        require(address(this).balance > amount, "amount not available");
        payable(msg.sender).transfer(amount);
    }

    function deposit(uint256 amount) public  payable {
        require(msg.value == amount, "Amount not available");
        // uint256 amount = msg.value;
        // address payee = msg.sender;
        // _deposits[payee] = _deposits[payee] + amount;
        // emit Deposited(payee, amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

}
