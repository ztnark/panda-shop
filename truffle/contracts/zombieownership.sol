pragma solidity ^0.4.23;

import "./zombieFactory.sol";

contract ZombieOwnership is ZombieFactory {

  mapping (uint => address) zombieApprovals;

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownedZombies[_owner].length;
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return zombieToOwner[_tokenId];
  }

  function zombiesOf(address _owner) public view returns (uint256[] _ownedZombieIds) {
    return ownedZombies[_owner];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownedZombies[_to].push(_tokenId);
    uint zombieIndex = ownedZombieIndex[_tokenId];
    delete ownedZombies[_from][zombieIndex];
    zombieToOwner[_tokenId] = _to;
    //Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _to;
    //Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(zombieApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
  
  function () payable public {
    if (msg.value > 0) {
      createRandomZombie();
    }
  }
}