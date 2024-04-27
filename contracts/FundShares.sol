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

    function mint(address to, uint256 amount) external;
    function mintUnits(address to, uint256 amount) external;
    function burnUnits(address from, uint256 val) external;
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
    address internal contractOwner;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, address _owner) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        owner = _owner;
        contractOwner = _owner;
    }

    function setContractOwner(address addr) public {
        require(msg.sender==owner, "Owner only");
        contractOwner = addr;
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
        require(msg.sender==owner||msg.sender==contractOwner, "Owner Only");
        _mint(to, amount);
    }

    function mintUnits(address to, uint256 amount) external {
        require(msg.sender==owner||msg.sender==contractOwner, "Owner Only");
        _mint(to, amount*10**uint256(decimals));
    }

    function burn(address from, uint256 amount) external {
        require(msg.sender==owner||msg.sender==contractOwner, "Owner Only");
        _burn(from, amount);
    }

    function burnUnits(address from, uint256 val) external {
        require(msg.sender==owner||msg.sender==contractOwner, "Owner Only");
        uint256 amount = val*10**uint256(decimals);
        _burn(from, amount);
    }

}

// solhint-disable
contract FundShares is ERC20 {
    constructor()
        ERC20("Fund Shares", "FGX", 2, msg.sender)
    {
    }
}
// solhint-enable

