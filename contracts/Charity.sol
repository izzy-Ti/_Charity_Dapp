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

    function createCharity(string memory _name) public {
        Charity storage newCharity = charities[charityCount] ;
        newCharity.name = _name;
        newCharity.charityAddress =payable (msg.sender);
        charityCount++;
    }

    function donate(uint charityIndex) public payable{
        uint _amount = msg.value;
        require(msg.value > 0.1 ether, "Amount less than minimum");
        
        charities[charityIndex].totalDonations = address(this).balance;
        charities[charityIndex].donors[msg.sender] = _amount;
    }

    function withdraw(uint charityIndex) public payable{
        require(msg.sender == charities[charityIndex].charityAddress, "You are not owner");
        uint balance = address(this).balance;
        payable (msg.sender).transfer(balance);
        charities[charityIndex].totalDonations = address(this).balance;
    }
}