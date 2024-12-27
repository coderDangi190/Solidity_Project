//SPDX-License-Identifier:MIT
pragma solidity ^0.8.28;

contract Lottery {
    address public owner;
    address[] public players;
    address public winner;
    uint256 public ticketPrice;
    bool public lotteryEnded;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can access the data.");
        _;
    }
    modifier onlyWinner() {
        require(msg.sender == winner, "Only Winner can access the data.");
        _;
    }
    modifier lotteryNotEnded() {
        require(!lotteryEnded, "The lottery has ended.");
        _;
    }
    constructor() {
        owner = msg.sender;
        ticketPrice = 1 ether;
    }
    function buyTicket() external payable lotteryNotEnded {
        require(msg.value == ticketPrice, "Invalid Ticket Price.");
        players.push(msg.sender);
    }
    function getPlayer() external view returns (address[] memory) {
        return players;
    }
    function endLottery() external onlyOwner lotteryNotEnded {
        require(
            players.length > 0,
            "Player is not participate in the lottery."
        );
        lotteryEnded = true;
        selectWinner();
    }
    function selectWinner() internal {
        uint256 luckyno = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, block.prevrandao, players)
            )
        ) % players.length;
        winner = players[luckyno];
    }
    function withdraw() external onlyWinner {
        require(lotteryEnded, "The lottery has not ended.");
        uint256 amount = address(this).balance;
        require(amount > 0, "There are no fund to withdraw");
        (bool sent, ) = payable(winner).call{value: amount}(" ");
        require(sent, "Transfer Failed!!");
    }
}
