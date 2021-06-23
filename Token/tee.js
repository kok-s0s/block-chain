var Web3 = require('web3');

var web3 = new Web3(Web3.givenProvider || "ws://localhost:7545");

let account="0x1F92276282d5494DC40aA5cda79fb762fbBDB5E6";

let balance =web3.eth.getBalance(account);

balance.then();