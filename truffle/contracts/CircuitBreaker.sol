pragma solidity ^0.4.23;

import "./ownable.sol";

contract CircuitBreaker is Ownable {

  bool public stopped = false;

  modifier stopInEmergency {require(!stopped); _;}

  function setStopped() public {
    require(msg.sender == owner);
    stopped = true;
  }
}