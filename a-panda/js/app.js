App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Load pets.
    return App.initWeb3();
  },
  
  initWeb3: function() {
    // metamask and mist inject their own web3 instances, so just 
    // set the provider if it exists
    if (typeof web3 !== "undefined") {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // set the provider you want from Web3.providers
      App.web3Provider = new web3.providers.HttpProvider("http://localhost:8545");
      web3 = new Web3(App.web3Provider);
    }

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('ZombieOwnership.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract.
      var ZombieArtifact = data;
      App.contracts.Zombie = TruffleContract(ZombieArtifact);

      // Set the provider for our contract.
      App.contracts.Zombie.setProvider(App.web3Provider);

      // // Use our contract to retieve and mark the adopted pets.
      // return App.markAdopted();
    });

    // return App.bindEvents();
  },

  // bindEvents: function() {
  //   $(document).on('click', '.btn-buy', App.buy);
  // },

  handleBuy: function() {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    var adoptionInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      App.contracts.Zombie.deployed().then(function(instance) {
        zombieInstance = instance;

        // return zombieInstance.createRandomZombie({from: account});
        debugger
        zombieInstance.sendTransaction({
          from: account,
          gas: 21000,
          value: 100000000000000000
        }).then(function(result) {
          debugger
          // return App.markAdopted();
        }).catch(function(err) {
          debugger
          // console.log(err.message);
        });
      })
    });
  },

  // markAdopted: function(adopters, account) {
  //   var adoptionInstance;

  //   App.contracts.Adoption.deployed().then(function(instance) {
  //     adoptionInstance = instance;

  //     return adoptionInstance.getAdopters.call();
  //   }).then(function(adopters) {
  //     for (i = 0; i < adopters.length; i++) {
  //       if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
  //         $('.panel-pet').eq(i).find('button').text('Pending...').attr('disabled', true);
  //       }
  //     }
  //   }).catch(function(err) {
  //     console.log(err.message);
  //   });
  // }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});

console.log("app")