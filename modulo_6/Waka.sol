// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";


contract WakandaToken is ERC20 {
    constructor() ERC20("WAKANDA", "WAKA") {
        _mint(msg.sender, 600_000_000 * 10 **decimals());
        
    }
}