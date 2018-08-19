pragma solidity ^0.4.19;

import "./ownable.sol";

contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
      uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;
    
    modifier onlyOwnerOf(uint _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        _;
    }

    function _createZombie(uint _dna) internal {
        uint id = zombies.push(Zombie(_dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _dna);
    }

    function _generateRandomDna() private view returns (uint) {
        uint rand = uint(keccak256(block.timestamp));
        return rand % dnaModulus;
    }

    function createRandomZombie() public {
        uint randDna = _generateRandomDna();
        randDna = randDna - randDna % 100;
        _createZombie(randDna);
    }
}
