pragma solidity ^0.4.23;

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
    mapping (address => uint[]) public ownedZombies;
    mapping (uint => uint) public ownedZombieIndex;
    
    modifier onlyOwnerOf(uint _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        _;
    }

    function _generateRandomDna() private view returns (uint) {
        uint rand = uint(keccak256(block.timestamp));
        return rand % dnaModulus;
    }

    function createRandomZombie() public {
        uint randDna = _generateRandomDna();
        randDna = randDna - randDna % 100;
        uint id = zombies.push(Zombie(randDna)) - 1;
        zombieToOwner[id] = msg.sender;
        uint256 length = ownedZombies[msg.sender].length;
        ownedZombies[msg.sender].push(id);
        ownedZombieIndex[id] = length;
        return NewZombie(id, randDna);
    }
}
