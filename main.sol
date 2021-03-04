// SPDX-License-Identifier: GPL-3.0  
pragma solidity ^0.7.4;
pragma experimental ABIEncoderV2;

contract NBAContract{
    uint number;
    function store(uint num) public{
        number=num;
    }
    function retrieve() public view returns (uint){
        return number;
    }
}