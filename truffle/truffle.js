module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      host: 'rinkeby.infura.io/KlNoGrmiL7INbW6VuqlB',
      port: 80,
      network_id: 4,
      gas: 4612388
    }
  }
};