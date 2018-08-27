# CryptoPandas
This project is an ERC-721 token for VR "Cryptopandas". Currently, the front-end allows you to purchase a random CryptoPanda Token, and the contract follows the ERC-721 protocol. This document includes notes on the requirements for the project. Owned CryptoPandas will appear in your world (currently requires refresh)

## Run the Application
To run the application:

1. Start ```testrpc```
2. ```cd truffle && truffle compile && truffle migrate```
3. ```cp build/pandaownership.json ../a-panda/PandaOwnership.json```
4. ``` cd ../a-panda && npm install```
5. ```http-server```
6. Navigate to the provided url (most likely http://localhost:8080)
