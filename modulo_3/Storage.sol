// SPDX-License-Identifier: GPL-3.0 --> Licencia de Uso

pragma solidity >=0.7.0 <0.9.0; // Versión del compilador de solidity

/**
 * @title Storage
 * @dev Modifica y devuelve el estado de una variable.
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage { //Definiendo el Nombre del contrato
    
    //declaración de structs
    struct Slot {
        //declaración de una variable de estado de tipo uint256.
        uint256 slot;
        //declaracion de una variable de estado de tipo address.
        address executor;
    }

    //declaracion de enums    
    enum SWITCH {ON, OFF}

    //declaración de una variable de estado de tipo struct Slot 
    Slot _slot;
    
    //declaracion de una variable de estado de tipo enum SWITCH
    SWITCH _switch;

    //declaración de evento
    event NewSlot(uint256 indexed value, address indexed operator);
    
    //declaración de modificadores de función
    modifier isPair(uint256 _value) {
        require (_value % 2 == 0, "error");
        _;
    }

    modifier isOn() {
        require (_switch == SWITCH.ON, "The slot is in OFF");
        _;
    } 

    //declaración de constructor
    constructor() {
        _switch = SWITCH.OFF;
    }

    //declaración de funciones
    function on() external returns (SWITCH) {
        _switch = SWITCH.ON;
        return _switch;
    }

    function off() external returns (SWITCH) {
        _switch = SWITCH.OFF;
        return _switch;
    }

    //declaración de función setter, con parámetros de entrada.
    function setSlot(uint256 value) external isOn {
        _slot.slot = value;
        _slot.executor = msg.sender;
        //invocación del evento NewSlot
        emit NewSlot(value, msg.sender);
    }

    //declaración de función getter que devuelve un valor de tipo uint256.
    function getSlot() external view returns (Slot memory) {
        return _slot;
    }

}