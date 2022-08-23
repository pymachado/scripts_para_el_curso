// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherStore {

    mapping (address => uint256) balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] >= 1 ether);
        (bool success,) = msg.sender.call{value: balances[msg.sender]}("");
        require(success);
        delete balances[msg.sender]; 
    }

    function balanceOf(address user) public view returns(uint256) {
        return balances[user];
    }

    function liquidity() public view returns(uint256) {
        return address(this).balance;
    }

}