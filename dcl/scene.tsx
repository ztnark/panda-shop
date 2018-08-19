import { createElement, ScriptableScene } from "metaverse-api"
import Web3 = require("web3")

export default class EthereumProvider extends ScriptableScene {
  async sceneDidMount() {
    const provider = await this.getEthereumProvider()
    const web3 = new Web3(provider)

    web3.eth.getBlock(48, function(error: Error, result: any) {
      console.log("Eth block 48 (from scene)", result)
    })
  }

  async render() {
    return <scene />
  }
}