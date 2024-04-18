/**
 *Submitted for verification at Etherscan.io on 2023-03-14
*/
// File: contracts/mocks/WETH.sol
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
}

contract ERC20 is IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner, address indexed spender, uint256 value
    );

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name;
    string public symbol;
    uint8 public decimals;
    address internal owner;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, address _owner) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        owner = _owner;
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount)
        external
        returns (bool)
    {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    function _burn(address from, uint256 amount) internal {
        balanceOf[from] -= amount;
        totalSupply -= amount;
        emit Transfer(from, address(0), amount);
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender==owner, "Owner Only");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }
}

// solhint-disable
contract FundShares is ERC20 {
    uint256 public minPrice = 1289 wei; // todo set this dynamic in the future
    event Deposit(address indexed dst, uint wad);

    constructor()
        ERC20("Fund Shares", "FGX", 2, msg.sender)
    {
        // Mint 100 tokens to msg.sender
        // Similar to how
        // 1 dollar = 100 cents
        // 1 token = 1 * (10 ** decimals)
        // _mint(msg.sender, 100000 * 10 ** uint256(decimals));
    }

    // function setPeg(uint256 minPri) public {
    //     require(msg.sender==owner, "Owner Only");
    //     minPrice = minPri;
    // }

    // function deposit() public payable {
    //     uint Amount = msg.value;
    //     address payee = msg.sender;
    //     require(Amount>=1289 wei, "Min amount is 1289WEI");

    //     // uint fundSharesAmount = (Amount/minPrice) * 10 ** uint256(decimals);
    //     uint fundSharesAmount;
    //     unchecked {
    //         fundSharesAmount =  (Amount/minPrice); 
    //     }
    //     //_mint(payee, fundSharesAmount*10 ** uint256(1));
    //     this.transferFrom(owner, payee, fundSharesAmount);
    //     emit Deposit(payee, fundSharesAmount);
    // }

    // function withdraw(uint wad) public {
    //     require(balanceOf[msg.sender] >= wad);
    //     balanceOf[msg.sender] -= wad;
    //     uint originalValue = wad * minPrice;
    //     payable(msg.sender).transfer(originalValue);
    //     emit Withdrawal(msg.sender, wad);
    // }
}
// solhint-enable

