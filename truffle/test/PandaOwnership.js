var PandaOwnership = artifacts.require("pandaownership");

contract('PandaOwnership', function(accounts) {
  it("should buy a panda", function(){
    return PandaOwnership.deployed().then(function(instance) {
      instance.sendTransaction({from:accounts[0], value:100000000000000})
      return instance
    }).then(function(instance){
      instance.pandaToOwner(0).then((res) => {
        assert.equal(res, accounts[0], "account at index 0 owns the panda")
      })
    })
  })
  it("should return all the users pandas", function(){
    return PandaOwnership.deployed().then(function(instance) {
      return instance.pandasOf(accounts[0])
    }).then((res) => {
      assert.equal(res[0].c[0], 0, "account at index 0 only owns panda with the id 0")
    })
  })
  it("should transfer a panda", function(){
    return PandaOwnership.deployed().then(function(instance) {
      instance.transfer(accounts[1], 0)
      return instance
    }).then((instance) => {
      instance.pandasOf(accounts[1]).then((res) => {
        console.log(res)
        assert.equal(res[0].c[0], 1, "ownership of panda 1 has been transfered to account at index 1")
      })
    })
  })
  it("should return panda data", function(){
    PandaOwnership.deployed().then(function(instance) {
      instance.panda(0).then((res) => {
        assert.equal(res[0].c, 0, "owner has panda 0")
      })
    })
  })
})