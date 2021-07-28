pragma solidity ^0.7.0;

import "./ArgonLottery.sol";

contract ArgonLotteryFactory is Ownable {
    address[] public lotteries;

    function getLotteries() public view returns (address[] memory) {
        return lotteries;
    }

    function createNewLottery(
        bool _lotteryStatus,
        uint256 _tokenPerTicket,
        uint256 _maxTicketCount,
        uint256 _startTime,
        uint256 _endTime,
        uint256 _rewardTokenAmount,
        IERC20 _token,
        IERC20 _rewardToken
    ) public onlyOwner {
        ArgonLottery newLottery = new ArgonLottery(
            _lotteryStatus,
            _tokenPerTicket,
            _maxTicketCount,
            _startTime,
            _endTime,
            _rewardTokenAmount,
            _token,
            _rewardToken
        );
        require(
            _rewardToken.transferFrom(
                msg.sender,
                address(newLottery),
                _rewardTokenAmount
            )
        );
        newLottery.transferOwnership(msg.sender);
        lotteries.push(address(newLottery));
    }
}
