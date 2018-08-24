pragma solidity ^0.4.11;

import 'zeppelin/contracts/math/SafeMath.sol';

contract EthPMExample {
  using SafeMath for uint256;

  uint8 public decimals = 8;
  // Mapping from user to token balance
  mapping (address => uint256) balances;

    /**
   * @dev Exchanges ETH for token balance at a rate of 1:100000000
   */
  function () payable public {
    balances[msg.sender] = msg.value * (10 ** uint256(decimals));
  }
}