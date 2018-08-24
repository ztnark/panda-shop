pragma solidity ^0.4.23;

import "./ownable.sol";

contract PandaFactory is Ownable {

    event NewPanda(uint pandaId, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Panda {
      uint dna;
    }

    Panda[] public pandas;

    // Mapping from panda ID to owner address
    mapping (uint => address) public pandaToOwner;
    // Mapping from owner address to uint[Pandas]
    mapping (address => uint[]) public ownedPandas;
    // Mapping from panda ID to owner panda index
    mapping (uint => uint) public ownedPandaIndex;
    
    /**
   * @dev Modifier to make a function callable only when caller is the owner
   */
    modifier onlyOwnerOf(uint _pandaId) {
        require(msg.sender == pandaToOwner[_pandaId]);
        _;
    }

    /**
   * @dev Generates the DNA used to determine the pandas look and abilities
   * @return uint representing the panda's dna
   */
    function _generateRandomDna() private view returns (uint) {
        uint rand = uint(keccak256(block.timestamp));
        return rand % dnaModulus;
    }
    
    /**
   * @dev Creates a random panda, and assigns it to the message sender
   */
    function createRandomPanda() internal {
        uint randDna = _generateRandomDna();
        randDna = randDna - randDna % 100;
        uint id = pandas.push(Panda(randDna)) - 1;
        pandaToOwner[id] = msg.sender;
        uint256 length = ownedPandas[msg.sender].length;
        ownedPandas[msg.sender].push(id);
        ownedPandaIndex[id] = length;
        return NewPanda(id, randDna);
    }
}
