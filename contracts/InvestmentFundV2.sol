// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount)
        external
        returns (bool);

    function mint(address to, uint256 amount) external;
    function mintUnits(address to, uint256 amount) external;
    function burnUnits(address from, uint256 val) external;
}

contract InvestmentFund {
    // using SafeMath for uint256;
    struct ShareHolder {
        uint256 Amount;
        string Klass;
        bool IsActive;
    }

    IERC20 private fundShares;
    mapping(address => uint256) private _shareholders;
    uint256 public shareSupply;
    address internal investor;
    address internal coInvestor;
    uint256 public maxInvestable;
    uint256 public minPrice = 1289 wei;

    event Deposited(address indexed payee, uint256 shares, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);
    event NewInvestor(address indexed invest, string klass, uint256 weiAmount);
    event SharesWithdrawn(address indexed addr, uint256 shareCount);
    event SharesSold(address indexed addr, uint256 shareCount, uint256 totalPayed);

    constructor(address sharesTokenAddr) {
        investor = msg.sender; // contract creator is the investor
        fundShares = IERC20(sharesTokenAddr); // token liquidity provider
    }

    function setMinPrice(uint256 price) external  {
        minPrice = price;
    }

    function setMaxInvestableByCoInvestor(uint256 amount) public {
        require(msg.sender==investor, "Investor Only");
        maxInvestable = amount;
    }

    function setCoInvestor(address nInvest) public {
        require(msg.sender==investor, "Investor Only");
        coInvestor = nInvest;
    }

    // Get Fund Balance
    function getBalance() view public  returns (uint256) {
        return address(this).balance;
    }

    function myBalance() view public returns (uint256) {
        address payee = msg.sender;
        return _shareholders[payee];
    }

    function transferShares(address to, uint256 amount) public  {
        require(_shareholders[msg.sender]>=amount, "r[transferShares] Share amount not available");
        _shareholders[msg.sender] -= amount;
        _shareholders[to] += amount;
        // shareSupply -= amount;
        // fundShares.mintUnits(to, amount);
        // uint sharesAmount = amount*10**uint256(2);
        // fundShares.transferFrom(investor, to, sharesAmount);
        // mint will work here because it's called with this contract as the msg.sender
        // fundShares contract address can be set with .setContractOwner on the FundShares token
        // fundShares.mintUnits(to, amount);
    }

    function withdrawShares(uint256 amount, address addr) public {
        address payee = msg.sender;
        // uint256 amount = shareCount*10**uint256(2);
        require(_shareholders[payee]>= amount, "r[withdrawShares] Amount not available");
        require(_shareholders[payee] > 0, "r[withdrawShares] You have no shares");

        fundShares.mintUnits(addr, amount);
        _shareholders[payee] -= amount;
        shareSupply -= amount;

        emit SharesWithdrawn(addr, amount);
    }

    // sellShares will attempt
    // to exchange the shares with ETH (Wei amounts)
    // if the total fund allows it
    // ex: 10FGX = 10 * minPrice = weiAmountToPay
    function sellShares(uint amount, address addr) public {
        address payee = msg.sender;
        require(_shareholders[payee] >= amount, "r[sellShares] Amount not available");
        require(_shareholders[payee] > 0, "r[sellShares] You have no shares");

        uint256 fundSize = address(this).balance;
        // what happens when minPrice increases???
        // it must be that each share withdraws...
        uint256 amountToPay = amount * minPrice;
        // 0.004821213976917991

        // a little redundant, but useful for debugging
        require(fundSize >= amountToPay, "r[sellShares] Fund not available");

        _shareholders[payee] -= amount;
        shareSupply -= amount;
        payable(addr).transfer(amountToPay);
        // 0.004821213976905101
        // if (fundShares.balanceOf(payee) > 0) {
        //     // user has fund-shares, should we burn them ??
        //     fundShares.burnUnits(payee, amount);
        // }
        emit SharesSold(addr, amount, amountToPay);
    }

    function deposit() public payable {
        // require(msg.value == amount, "Amount not available");
        require(msg.value >= minPrice, "r[deposit] Amount must be multiples of minPrice");
        address payee = msg.sender;
        uint amount = msg.value;
        uint sharesCount = 0;
        uint i=minPrice;

        for (; i<=amount; i+=minPrice) {
            sharesCount += 1;
        }

        _shareholders[payee] += sharesCount;
        shareSupply += sharesCount;
        emit Deposited(payee, sharesCount, amount);
    }

    function invest(uint amount, address asset, string memory label) public {
        require(address(this).balance >= amount, "amount not available");
        // requires that its either the investor or the coInvestor requesting amount less set
        require(msg.sender == investor || (msg.sender==coInvestor&&amount<maxInvestable),
            "Must be investor or coInvestor");
        // payable(addr).transfer(amount);
    }

}
