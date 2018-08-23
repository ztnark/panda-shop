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

    mapping (uint => address) public pandaToOwner;
    mapping (address => uint[]) public ownedPandas;
    mapping (uint => uint) public ownedPandaIndex;
    
    modifier onlyOwnerOf(uint _pandaId) {
        require(msg.sender == pandaToOwner[_pandaId]);
        _;
    }

    function _generateRandomDna() private view returns (uint) {
        uint rand = uint(keccak256(block.timestamp));
        return rand % dnaModulus;
    }

    function createRandomPanda() public {
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
