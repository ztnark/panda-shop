var ownable = artifacts.require("./ownable.sol");
var zombiefactory = artifacts.require("./zombiefactory.sol");
var zombieownership = artifacts.require("./zombieownership.sol");


module.exports = function(deployer) {
  deployer.deploy(ownable);
  deployer.deploy(zombiefactory);
  deployer.deploy(zombieownership);
};
