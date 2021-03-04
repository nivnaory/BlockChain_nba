const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
//const { assertRequest, getAddress, RequestPurpose, compiledBinaryContract } = require('./Utils');

const contractAbi = [{"inputs":[],"name":"retrieve","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"num","type":"uint256"}],"name":"store","outputs":[],"stateMutability":"nonpayable","type":"function"}];
var contreactAddress='0x13fcdDCE89750894ED8eb05efc905461B4683E2a';
const { exception } = require('console');
const { maxHeaderSize } = require('http');

let accounts =  web3.eth.getAccounts();
async function testing(){
let contract = await new web3.eth.Contract(contractAbi,contreactAddress);
await contract.methods.store(4).send({from:accounts[0],gas:'300000'});
let num=await contract.methods.retrieve().call();
console.log(num)
}
testing();