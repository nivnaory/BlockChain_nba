const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const compiledContractInterface=require('./bin/contracts/NBA_gembller.json');
const interface=compiledContractInterface.abi;
const bytecode=compiledContractInterface.bytecode;
var accounts;
var contract;

async function deploy() {
    accounts = await web3.eth.getAccounts();

    console.log('Attempting to deploy', accounts[0]);
    console.log(interface);

    const result = await new web3.eth.Contract(interface)
        .deploy({
            data: bytecode,
        })
        .send({
            gas: 3000000,
            from: accounts[0]

        });

    console.log('Contract deployed to ', result.options.address);
    return result
};

async function createBattleTest(){
    contract = await deploy();
    await contract.methods.register('asaf','asafsuryano','1234').send({from:accounts[0],gas:'300000'});
    await contract.methods.register('niv','niv','1234').send({from:accounts[0],gas:'3000000'});
    await contract.methods.addUserGambling('asafsuryano').send({from:accounts[0],gas:'3000000'});
    await contract.methods.addUserGambling('niv').send({from:accounts[0],gas:'3000000'});
    let battle=await contract.methods.getGamblingBattle(0).call();
    console.log(battle)
}


createBattleTest();
