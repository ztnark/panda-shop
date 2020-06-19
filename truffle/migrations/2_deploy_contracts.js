var ownable = artifacts.require("./Ownable.sol");
var circuitbreaker = artifacts.require("./CircuitBreaker.sol");
var pandafactory = artifacts.require("./PandaFactory.sol");
var pandaownership = artifacts.require("./PandaOwnership.sol");


module.exports = function(deployer) {
  deployer.deploy(ownable);
  deployer.deploy(pandafactory);
  deployer.deploy(pandaownership);
  deployer.deploy(circuitbreaker);
};
