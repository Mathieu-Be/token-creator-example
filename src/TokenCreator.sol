// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./FactoryInterface.sol";

contract TMTokenCreator {
    ITMFactory public factory;
    address public wnative;

    address user1 = 0x78094C71333559E2f150A1B6C404bD02ba0A8AC4;
    address user2 = 0x2fe599dA7199E80b7eD9b165014c66f317a3878E;

    constructor(address _factory, address _wnative) {
        factory = ITMFactory(_factory);
        wnative = _wnative;
    }

    function createToken() external payable {
        uint256[] memory bidPrices = new uint256[](2);
        bidPrices[0] = 0;
        bidPrices[1] = 100e14;

        uint256[] memory askPrices = new uint256[](2);
        askPrices[0] = 0;
        askPrices[1] = 990e14;

        uint256 amountIn = 35 * 10 ** 15;
        uint256 minAmountOut = 25 * 10 ** 15;

        require(msg.value > amountIn, "Insufficient AVAX");

        ITMFactory.VestingParameters[] memory vestingParams = new ITMFactory.VestingParameters[](2);

        vestingParams[0] = ITMFactory.VestingParameters(user1, 3000, uint80(block.timestamp + 100), 10 days, 60 days);
        vestingParams[1] = ITMFactory.VestingParameters(user2, 7000, uint80(block.timestamp + 100), 10 days, 60 days);

        uint256 totalSupply = 1e25;
        uint16 creatorShare = 4000;
        uint16 stakingShare = 4000;
        bytes memory encodedDecimals = abi.encode(18);

        ITMFactory.MarketCreationParameters memory marketCreation = ITMFactory.MarketCreationParameters({
            tokenType: 1,
            name: "Test Token2",
            symbol: "TST2",
            quoteToken: wnative,
            totalSupply: totalSupply,
            creatorShare: creatorShare,
            stakingShare: stakingShare,
            bidPrices: bidPrices,
            askPrices: askPrices,
            args: encodedDecimals
        });

        factory.createMarketAndVestings{value: amountIn}(marketCreation, vestingParams, user1, amountIn, minAmountOut);
    }
}
