
This project is an ERC-721 token for VR "Cryptopandas". Currently, the front-end allows you to purchase a random CryptoPanda Token, and the contract follows the ERC-721 protocol. This document includes notes on the requirements for the project.

## Design Pattern Requirements

##### Emergency Stop
I have implimented an emergency stop that allows the contract creator to prevent purchasing of CryptoPandas in the case of an emergency/error in the contract code.

##### Fail Early Fail Loud
Contract functions begin with require statements to ensure that transactions are valid before executing contract code. 

#### Restricting Access
All functions related to control of CryptoPandas are restricted to the current Panda owner through the onlyOwnerOf modifier. This modifier ensures that the sender is the current owner of the Panda. In addition, the contract itself inherits from the ownable contract, which sets the account who deployed the contract as the owner, and only allows that user to transfer the contract.
