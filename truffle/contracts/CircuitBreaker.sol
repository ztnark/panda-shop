pragma solidity ^0.4.23;

import "./Ownable.sol";

contract CircuitBreaker is Ownable {

  bool public stopped = false;

  /**
  * @dev Modifier to stop a call if the emergency breaker is switched
  */
  modifier stopInEmergency {require(!stopped); _;}

   /**
   * @dev Flips the emergency switch on
   */
  function setStopped() public {
    require(msg.sender == owner);
    stopped = true;
  }
}