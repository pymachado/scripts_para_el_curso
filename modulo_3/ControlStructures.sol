// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.9.0;

contract ControlStructures {

    enum ControlSTructures {Conditionals, Loops}
    
    uint256 count;
    //string _msg;

    function select(ControlSTructures controlSt) external returns(string[] memory) {
        if (controlSt == ControlSTructures.Conditionals) {
            return callConditional();
        } else if (controlSt == ControlSTructures.Loops) {
            return callLoop();
        }
        else {
            string memory _msg = "ninguna opcion";
            revert(_msg);
        }
    }

    function callConditional() private returns (string[] memory) {
        count = 1;
        string[] memory times = new string[](count);
        string memory _msg = "esto es un condicional";
        times[0] = _msg;
        count = 0;
        return times;
    }

    function callLoop() private returns (string[] memory) {
        count +=1;
        string memory _msg = "esto es un loop";
        string[] memory times =  new string[](count);
        for (uint8 i = 0; i < count;) {
            times[i] = _msg;
            unchecked {i++;}          
        } 
        return times;
    }
}