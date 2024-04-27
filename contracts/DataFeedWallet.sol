pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract DataFeedChainLink {
    AggregatorV3Interface internal dataFeed;
    AggregatorV3Interface internal etherUSDFeed;
    address owner;

    constructor() {
        owner = msg.sender;
        dataFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );

        etherUSDFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function deposit() public payable {
        uint amount = msg.value;
        int ethUSD = getETHUSD();
        if (ethUSD < 3275) {
            require(false, "Preco de ETH abaixo de 3270");
        }
    }

    function withdrawal(uint amount) public {
        require(address(this).balance > amount, "amount not available");
        require(msg.sender==owner, "Only Owner Allowed");

        address dest = msg.sender;
        payable(dest).transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getETHUSD() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = etherUSDFeed.latestRoundData();
        int etherUsd = answer / 100000000.0;
        return etherUsd;
    }

}