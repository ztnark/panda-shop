pragma solidity ^0.4.23;

import "./pandaFactory.sol";

import "./CircuitBreaker.sol";


contract PandaOwnership is PandaFactory, CircuitBreaker {

  mapping (uint => address) pandaApprovals;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownedPandas[_owner].length;
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return pandaToOwner[_tokenId];
  }

  function pandasOf(address _owner) public view returns (uint256[] _ownedPandaIds) {
    return ownedPandas[_owner];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownedPandas[_to].push(_tokenId);
    uint pandaIndex = ownedPandaIndex[_tokenId];
    delete ownedPandas[_from][pandaIndex];
    pandaToOwner[_tokenId] = _to;
    //Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    pandaApprovals[_tokenId] = _to;
    //Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(pandaApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
  
  function () stopInEmergency payable public {
    if (msg.value > 0) {
      createRandomPanda();
    }
  }
}