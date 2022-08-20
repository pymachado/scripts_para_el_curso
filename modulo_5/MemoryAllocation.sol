// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract MemoryAllocation {
    //toda variable declarada en esta área del contrato se almacena por defecto en el storage.
    //no se especifica el almacenamiento. 
    
    uint256 public slot0; //el valor de slot0 se encuentra en el estorage del contrato. 

    struct Student {
        string name;
    }

    function incrementSlot() external {
       slot0 += 1;
    }

    function studentInMemory() external pure returns(Student memory) {
        Student memory student;
        student.name = "Meliodas";
        return student;
    }

    function slot0InStack() public pure {
        uint256 x;
        x = 1;
        return x;
    }

    function sendingInCallData(Student calldata student) public returns (uint256) {
        require (student.name == "Eren");
        return slot0;
    }


}