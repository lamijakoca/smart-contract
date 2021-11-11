// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

contract TrustFund {
    struct Kid{
        uint amount;
        uint maturity;
        bool paid;
    }
    
    mapping (address=>Kid) public kids;
    address public admin;


    constructor(){
        admin = msg.sender;
    }
    
    function addKid(address kid, uint ttMaturity) external payable{
        require(msg.sender == admin, 'admin only');
        require(kids[msg.sender].amount == 0, 'kid already exists');
        kids[kid] = Kid(msg.value, block.timestamp + ttMaturity, false);
    }

    function withDraw() external{
        Kid storage kid = kids[msg.sender];
        require(kid.maturity <= block.timestamp, 'too early');
        require(kid.amount > 0, 'only kid can do this');
        require(kid.paid == false, 'paid already');
        kid.paid = true;
        payable(msg.sender).transfer(kid.amount);
    }
}