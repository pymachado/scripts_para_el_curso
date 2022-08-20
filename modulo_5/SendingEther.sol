// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0; 

contract ReceptorEther {
    uint256 public x;

    event EtherReceived(address sender, uint256 amount);

    function balance() external view returns(uint256) {
        return address(this).balance;
    }

    //declaración de la función receive() 
    //para que el contrato pueda recibir Ethers de forma plana.
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    //las funciones fallbacks pueden modificar el estado 
    //del contrato siempre que tengan gas disponible.
    fallback() external payable {
        x++;
        emit EtherReceived(msg.sender, msg.value);
    }

}

contract Caller {
    uint256 constant VALUE = 1 ether;
    
    //iniializamos el contrato con un monto de ethers.
    constructor() payable {}

    //envia ethers con .send(), hay que encuestar el valor devuelto.
    //consumo de GAS fijo a 2300.
    function _send(ReceptorEther test) public {
        bool success = payable(test).send(VALUE);
        require(success, "Error sending money");
    }

    //envio de manera segura con .transfer(), no devuelve nada.
    //consumo de GAS ajustado a 2300.
    function _transfer(ReceptorEther test) public {
        payable(test).transfer(VALUE);
    }

    //envio de ethers con .call{value:uint256, gas:uint256}(""), 
    //devuelve false en caso de que falle la transferencia, 
    //gas ajustable.
    function _call(ReceptorEther test, uint256 gasFixedTo) public {
        (bool success,) = address(test)
        .call{value: VALUE, gas: gasFixedTo}(abi.encodeWithSignature("ghost()"));
        require(success, "Error sending money");
    }

    function balance() external view returns(uint256) {
        return address(this).balance;
    }
}