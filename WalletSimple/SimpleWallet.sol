//SPDX-License-Identifier:MIT

pragma solidity ^0.8.28;

contract walletSimple {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function Deposit() external payable {}

    function Withdraw() public payable {
        uint256 amount = address(this).balance;
        (bool sent, ) = owner.call{value: amount}(" ");
        require(sent, "Failed to send Ether.");
    }

    function Transferamount(address _to, uint _amount) public payable {
        (bool sent, ) = _to.call{value: _amount}(" ");
        require(sent, "Transfer Faile!!!");
    }
}
