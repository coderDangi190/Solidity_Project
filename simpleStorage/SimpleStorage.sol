//SPDX-License-Identifier:MIT

pragma solidity ^0.8.28;

contract simpleStorage {
    uint data;

    function store(uint _data) external {
        data = _data;
    }

    function retrieve() external view returns (uint) {
        return data;
    }
}
