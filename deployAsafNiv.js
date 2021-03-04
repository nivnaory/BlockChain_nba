//const HDWalletprovider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const ganache = require('ganache-cli');
const path = require('path');

//const profilePath = path.resolve(__dirname, 'bin/BlockChain_nba/contracts/NBAContract.json');

//const compiledProfile = require(profilePath);

console.log('hello');

const compiledContractInterface=require('./bin/contracts/NBAContract.json');
const interface=compiledContractInterface.abi;
const bytecode=compiledContractInterface.bytecode;
var accounts;
var contract;
//  const provdier = new HDWalletprovider(
// //     'page basic neutral unaware target rather tattoo poet dutch flag luxury minute',
// //     'https://ropsten.infura.io/v3/9ba5464e1e3e43da9d605d467f5b4f74'
// // );
// // const web3 = new Web3(provider);

const web3 = new Web3(ganache.provider());

async function deploy() {
    accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy', accounts[0]);
    console.log(interface);

    const result = await new web3.eth.Contract(interface)
        .deploy({
            data: bytecode,
        })
        .send({
            gas: '4000000',
            from: accounts[0]
        });

    console.log('Contract deployed to ', result.options.address);
    return result
};


async function deploying(){
contract = await deploy();
}
deploying();
console.log();