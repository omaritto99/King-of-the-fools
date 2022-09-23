// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

contract KingOfFools is Ownable {
    uint256 public previousPersonBid = 0 ether;
    address public previousPersonAdress;
    bool public paused = false;

    constructor() {}

    function Send() public payable {
        require(!paused, "The contract is paused!");
        require(
            msg.value >= previousPersonBid + previousPersonBid / 2,
            "Please Send a higher x1.5 Bid"
        );

        if (previousPersonAdress != address(0)) {
            (bool os, ) = payable(previousPersonAdress).call{value: msg.value}(
                ""
            );
            require(os);
        }
        previousPersonBid = msg.value;
        previousPersonAdress = msg.sender;
    }

    function setPreviousPersonBid(uint256 _previousPersonBid) public onlyOwner {
        previousPersonBid = _previousPersonBid;
    }

    function setPaused(bool _state) public onlyOwner {
        paused = _state;
    }

    function setPreviousPersonAdress(address _adress) public onlyOwner {
        previousPersonAdress = _adress;
    }
}
