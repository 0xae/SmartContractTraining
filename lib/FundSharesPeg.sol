/**
 *Submitted for verification at Etherscan.io on 2023-03-14
*/
// File: contracts/mocks/WETH.sol
pragma solidity ^0.8.7;


// solhint-disable
contract FundSharesPeg {
    string public name = "Fund Shares";
    string public symbol = "FGX";
    uint8  public decimals = 2;
    uint256 public minPrice = 1289 wei; // todo set this dynamic in the future
    address internal owner;
    uint internal totalInCirc;

    event  Approval(address indexed src, address indexed guy, uint wad);
    event  Transfer(address indexed src, address indexed dst, uint wad);
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    mapping (address => uint) public  balanceOf;
    mapping (address => mapping (address => uint))  public  allowance;

    constructor() {
        owner = msg.sender;
        // generate some Shares to the owner to save him gas
    }

    receive() external payable {
        deposit();
    }

    function setPeg(uint256 minPri) public {
        minPrice = minPri;
    }

    function mint(uint fundSharesAmount) public {
        require(msg.sender==owner, "Contract owner only");
        address Receiver = msg.sender;
        balanceOf[Receiver] += fundSharesAmount;
        totalInCirc += fundSharesAmount;
        emit Deposit(Receiver, fundSharesAmount);
    }

    function deposit() public payable {
        uint Amount = msg.value;
        address payee = msg.sender;
        require(Amount>=1289, "Min amount is 1289WEI");

        uint fundSharesAmount = Amount/minPrice;
        balanceOf[payee] += fundSharesAmount;
        totalInCirc += fundSharesAmount;

        emit Deposit(payee, fundSharesAmount);
    }

    // function withdraw(uint wad) public {
    //     require(balanceOf[msg.sender] >= wad);
    //     balanceOf[msg.sender] -= wad;
    //     uint originalValue = wad * minPrice;
    //     payable(msg.sender).transfer(originalValue);
    //     emit Withdrawal(msg.sender, wad);
    // }

    function totalSupply() public view returns (uint) {
        return totalInCirc;
    }

    function approve(address guy, uint wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    function transfer(address dst, uint wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    function transferFrom(address src, address dst, uint wad)
        public
        returns (bool)
    {
        require(balanceOf[src] >= wad);

        if (src != msg.sender && allowance[src][msg.sender] != uint(0)) {
            require(allowance[src][msg.sender] >= wad);
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        emit Transfer(src, dst, wad);

        return true;
    }
}
// solhint-enable