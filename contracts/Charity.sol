// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.30;


contract charity {
    address owner;

    uint public charityCount = 0;

    constructor() {
        owner = msg.sender;
    }
    struct Charity {
        string name;
        address payable charityAddress;
        uint256 totalDonations;
        uint256 fundsWithdrawn;
        mapping(address => uint256) donors;
    }

    mapping(uint => Charity) public charities;

    function createCharity(string memory _name, address payable _charityAddress) public {
        charityCount++;
        Charity storage newCharity = charities[charityCount] ;
        newCharity.name = _name;
        newCharity.charityAddress = _charityAddress;
    }
}