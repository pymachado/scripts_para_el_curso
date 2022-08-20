// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Base {
    uint256 public x;
    
    function execute() external returns (uint256) {
        return x += 1;
    } 
}

contract Caller {
    uint256 public x;
    
    //esta funcion se llama desde el contexto del contrato Caller pero modifica el estado del contrato Base.
    function callnBaseContext(address _base) external  returns (uint256) { 
        (bool success, bytes memory result) = _base.call(abi.encodeWithSignature("execute()"));
        require(success);
        return abi.decode(result, (uint256));
    }

    //esta funcion se llama desde el contexto del contrato Caller y afecta el estado del mismo contrato. 
    function callInCallerContext(address _base) external returns (uint256) {
        (bool success, bytes memory result) = _base.delegatecall(abi.encodeWithSignature("execute()"));
        require(success);
        return abi.decode(result, (uint256));
    }

}