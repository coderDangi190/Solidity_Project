//SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

//A basic ERC20 token implementation
contract MyToken {
    //Variable
    string public name = "MyToken";
    string public symbol = "SDK";
    uint8 public decimals = 18; //Standard is 18 decimals
    uint256 public totalSupply;

    // Balance and allowance
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    //Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    //Constructor to initialize the total supply to the contract deployer
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply; // Assign the entire supply to the contract deployer
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    // Transfer function
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    // Approve spender to use tokens on behalf of the owner
    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    // Transfer tokens on behalf of the owner
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // Mint new tokens (only by the contract owner)
    function mint(uint256 _amount) public {
        require(
            msg.sender == address(this),
            "Only the contract can mint tokens"
        );
        uint256 amountWithDecimals = _amount * (10 ** uint256(decimals));
        totalSupply += amountWithDecimals;
        balanceOf[msg.sender] += amountWithDecimals;
        emit Transfer(address(0), msg.sender, amountWithDecimals);
    }
    // Burn tokens
    function burn(uint256 _amount) public {
        uint256 amountWithDecimals = _amount * (10 ** uint256(decimals));
        require(
            balanceOf[msg.sender] >= amountWithDecimals,
            "Insufficient balance to burn"
        );

        totalSupply -= amountWithDecimals;
        balanceOf[msg.sender] -= amountWithDecimals;
        emit Transfer(msg.sender, address(0), amountWithDecimals);
    }
}
