// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//solución 1
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol";

contract EtherStoreWithReentrancyGuard  is ReentrancyGuard {

    mapping (address => uint256) balances;


    
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        uint256 valueToSend = balances[msg.sender];
        require( valueToSend>= 1 ether);
        //solucion 2
        //delete balances[msg.sender];
        (bool success,) = msg.sender.call{value: valueToSend}("");
        require(success);
        //solucion 3, usar transferenia segura.
        //payable(msg.sender).transfer(balances[msg.sender]);
        delete balances[msg.sender];
    }

    function balanceOf(address user) public view returns(uint256) {
        return balances[user];
    }

    function liquidity() public view returns(uint256) {
        return address(this).balance;
    }

}