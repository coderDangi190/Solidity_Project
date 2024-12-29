//SPDX-License-Identifier:MIT

pragma solidity ^0.8.28;

contract Message {
    mapping(address => string) message;

    function registerMessage(string memory _text) public {
        message[msg.sender] = _text;
    }

    function getMessage(address _adr) public view returns (string memory) {
        return message[_adr];
    }
}
