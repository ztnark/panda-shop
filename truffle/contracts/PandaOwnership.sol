pragma solidity ^0.4.23;

import "./PandaFactory.sol";

import "./CircuitBreaker.sol";


contract PandaOwnership is PandaFactory, CircuitBreaker {

  // Mapping from panda ID to approved address
  mapping (uint => address) pandaApprovals;

  /**
  * @dev Gets the balance of the specified address
  * @param _owner address to query the balance of
  * @return uint256 representing the amount of pandas owned by the passed address
  */
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownedPandas[_owner].length;
  }

    /**
   * @dev Gets the owner of the specified token ID
   * @param _tokenId uint256 ID of the token to query the owner of
   * @return owner address currently marked as the owner of the given token ID
   */
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return pandaToOwner[_tokenId];
  }
  
    /**
   * @dev Gets the pandas of the specified address
   * @param _owner address to query the balance of
   * @return uint256[] representing the pandas owned by the passed address
   */
  function pandasOf(address _owner) public view returns (uint256[] _ownedPandaIds) {
    return ownedPandas[_owner];
  }

    /**
   * @dev Transfers the ownership of a given token ID to another address
   * Usage of this method is discouraged, use `safeTransferFrom` whenever possible
   * Requires the msg sender to be the owner, approved, or operator
   * @param _from current owner of the token
   * @param _to address to receive the ownership of the given token ID
   * @param _tokenId uint256 ID of the token to be transferred
  */
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownedPandas[_to].push(_tokenId);
    uint pandaIndex = ownedPandaIndex[_tokenId];
    delete ownedPandas[_from][pandaIndex];
    pandaToOwner[_tokenId] = _to;
    //Transfer(_from, _to, _tokenId);
  }

  /**
   * @dev Transfers the ownership of a given token ID to another address
   * Requires the msg sender to be the owner
   * @param _to address to receive the ownership of the given token ID
   * @param _tokenId uint256 ID of the token to be transferred
  */
  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

    /**
   * @dev Approves another address to transfer the given token ID
   * The zero address indicates there is no approved address.
   * There can only be one approved address per token at a given time.
   * Can only be called by the token owner
   * @param _to address to be approved for the given token ID
   * @param _tokenId uint256 ID of the token to be approved
   */
  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    pandaApprovals[_tokenId] = _to;
    //Approval(msg.sender, _to, _tokenId);
  }

   /**
   * @dev Allows approved account to take ownership of a token
   * @param _tokenId uint256 ID of the token to be approved
   */
  function takeOwnership(uint256 _tokenId) public {
    require(pandaApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
  
  // @dev default function for buying new Panda Token
  function () stopInEmergency payable public {
    require(msg.value > 0);
    createRandomPanda();
  }
}