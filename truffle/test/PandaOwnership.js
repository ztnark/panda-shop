var PandaOwnership = artifacts.require("pandaownership");

contract('PandaOwnership', function(accounts) {
  it("should buy a panda", function(){
    return PandaOwnership.deployed().then(function(instance) {
      instance.sendTransaction({from:accounts[0], value:100000000000})
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
      instance.pandaToOwner(0).then((res) => {
        assert.equal(res, accounts[1], "account at index 1 owns panda with the id 0")
      })
    })
  })
  it("should return panda DNA", function(){
    return PandaOwnership.deployed().then(function(instance) {
      return instance.pandas(0).then((res) => {
        var expectedLength = 14 
        assert.equal(("" + res.c[1]).length, expectedLength, "Panda DNA should be 14 characters")
      })
    })
  })
  it("should return the pandas owner", function(){
    return PandaOwnership.deployed().then(function(instance) {
      return instance.pandaToOwner(0)
    }).then((res) => {
      assert.equal(res, accounts[1], "account at index 0 owns panda with the id 0")
    })
  })
})