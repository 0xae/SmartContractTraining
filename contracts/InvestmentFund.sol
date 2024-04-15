// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract InvestmentFund {
    // using SafeMath for uint256;
    struct ShareHolder {
        uint256 Amount;
        string Klass;
        bool IsActive;
    }

    mapping(address => ShareHolder) private _shareholders;
    address investor;
    address coInvestor;
    uint256 maxInvestable;
    string FundName;

    event Deposited(address indexed payee, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);
    event NewInvestor(address indexed invest, string klass, uint256 weiAmount);

    constructor(string memory ContractNameX) {
        FundName = ContractNameX;
        investor = msg.sender; // contract creator is the investor
    }

    function setMaxInvestable(uint256 amount) public {
        require(msg.sender==investor, "Investor Only");
        maxInvestable = amount;
    }

    function setCoInvestor(address nInvest) public {
        require(msg.sender==investor, "Investor Only");
        coInvestor = nInvest;
    }

    // Get Fund Balance
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function join() public payable {
        require(msg.value > 0, "Amount must not be zero");
        address payee = msg.sender;
        if (_shareholders[payee].IsActive) {
            require(false, "You are already investor");
        }

        _shareholders[payee] = ShareHolder({
            Amount: msg.value,
            Klass: "A",
            IsActive: true
        });
    }

    function deposit() public  payable {
        // require(msg.value == amount, "Amount not available");
        require(msg.value > 0, "Amount must not be zero");
        address payee = msg.sender;
        uint amount = msg.value;

        if (!_shareholders[payee].IsActive) {
            require(false, "You are not investor");
        }

        _shareholders[payee].Amount = _shareholders[payee].Amount + amount;
        emit Deposited(payee, amount);
    }

    function withdraw(uint amount) public {
        // require(address(this).balance > amount, "amount not available");
        // payable(msg.sender).transfer(amount);
    }

}
