// SPDX-License-Identifier: GPL-3.0 --> Licencia de Uso

pragma solidity >=0.7.0 <0.9.0; 

//declaracion de contrato Padre
contract Parent {
    event ShowAddress(address indexed contractAddress);
    //función base que puede cambiar su comportamiento.   
    function trigger() virtual external {
        emit ShowAddress(address(this));
    }
}

//declaración de contrato Hjo
contract Child is Parent {
    event ShowAddressCalledFrom(address indexed eoa);
    
    //llamada de la función base cambiando su comportamiento. 
    function trigger() override public {
        emit ShowAddress(address(this));
        emit ShowAddressCalledFrom(msg.sender);
    }
}