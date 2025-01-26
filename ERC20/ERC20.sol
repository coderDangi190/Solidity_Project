//SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract SADToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Silver", "Deci1") {
        _mint(msg.sender, initialSupply);
    }
    function decimals() public pure override returns (uint8) {
        return 1;
    }
}
