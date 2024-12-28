	//SPDX-License-Identifier:MIT

	pragma solidity ^0.8.28;

	import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol';
	
	contract FixedDeposit{
		uint public constant duration =365 days;
		uint public immutable end;
		address public payable immutable owner;

		constructor(address payable _owner){
			require(_owner != address(0),"Invalid Owner Address.");
			end = block.timestamp + duration;
			owner = _owner;
		}
		
		function deposit(address token, uint amount)external{
			require(_amount >0, "Amount must be greater than Zero.");
			IERC20(token).transferFrom(msg.sender, address(this), amount);
		}

		receive() external payable{}

		function withdraw(address token, uint amount) external{
			require(msg.sender == owner, "Only Owner can be access.");
			require(block.timestamp == end, "Your Fixed Deposit duration is not complete.");

			if(token == address(0)){
				//withdraw Ether
				owner.transfer(amount);
			}

			else{
				//Withdraw ERC20 token
				IRC20(token).transfer(owner,amount);
			}
		
		}

	
	}
