// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.9.0;

contract Scoping {
    //variable de estado global
    string constant globalWord = "global scope" ;

    function localScop() external pure returns (string memory) {
        //variable de estado local 
        string memory localWord = "local scop";
        return localWord;
    } 

    function globalScope() external pure returns (string memory) {
        return globalWord;
    }

    function bothScope() external view returns (string memory _local,
     string memory _global) {
        return (this.localScop(), globalWord);
    }

}