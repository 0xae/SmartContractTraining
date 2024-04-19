# Ethereum Developer Material

Research, Architecture, Development material for understanding and designing powerful and safe smart contracts.

### Ethereum Networks

We'll be using exclusively the Sepolia Test Network to do all works.
Learn more about [Sepolia on the ethereum website](https://ethereum.org/pcm/developers/docs/networks/#sepolia),

* Connect base to web3 [link](https://docs.base.org/docs/tools/web3/)
* The block explorer can be found [here](https://sepolia.etherscan.io/).
* Review this guide about connecting web3 [link](https://www.quicknode.com/guides/ethereum-development/getting-started/connecting-to-blockchains/how-to-connect-to-ethereum-network-with-web3js)

Also about [L2 Networks Testnets:](https://ethereum.org/pcm/developers/docs/networks/#layer-2-testnets)

## Tools
* [web3js wallets & accounts](https://docs.web3js.org/guides/wallet/)
* [local wallet](https://docs.web3js.org/guides/wallet/local_wallet)
* [web3js read the docs](https://web3js.readthedocs.io/en/v1.2.11/web3-eth-accounts.html#wallet-add)
* [solidity intro to smart-contracts](https://docs.soliditylang.org/en/v0.8.25/introduction-to-smart-contracts.html)
* [by example call contract](https://solidity-by-example.org/calling-contract/)
* [Connect to metamask web3js](https://docs.web3js.org/guides/getting_started/metamask)
* [hardhat](https://hardhat.org/hardhat-runner/docs/getting-started)


### Connect  web3.js to sepolia

```javascript
    const Web3 = require("web3");
    const web3 = new Web3("https://rpc2.sepolia.org");
```

[Ref Article](https://coinsbench.com/connecting-to-the-ethereum-testnet-using-only-web3-js-and-the-console-cffe0273b184)

## Hardhat
Hardhat is a development environment for Ethereum.Components for editing, compiling, debugging and deploying your smart contracts

[getting-started](https://hardhat.org/hardhat-runner/docs/getting-started)

## Misc

Production url: [https://eth.llamarpc.com/](https://eth.llamarpc.com/)

Links
====
* [web3.js migration to 4.0.0](https://docs.web3js.org/guides/web3_upgrade_guide/x/)
* [metamask window api](https://docs.metamask.io/wallet/concepts/wallet-api/#replacing-window-web3)
* [web3.js library](https://github.com/web3/web3.js)
* [web3js minified](https://npm.runkit.com/web3/dist/web3.min.js?t=1708960641472)
* [solidity examples, contains web3.js](https://docs.soliditylang.org/en/v0.8.25/solidity-by-example.html)
* [introduction to smart contracts (solidity)](https://docs.soliditylang.org/en/v0.8.25/introduction-to-smart-contracts.html)
* [remix online (your best friend)](https://remix.ethereum.org/)
* [download remix](https://github.com/ethereum/remix-desktop/releases)
* [testnet faucet para o sepolia](https://testnet.help/en/ethfaucet/sepolia#log)
