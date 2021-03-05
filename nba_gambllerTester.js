const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const compiledContractInterface=require('./bin/NBA_gembller.json');
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
    //create users
    await contract.methods.register('asaf','asafsuryano','1234').send({from:accounts[0],gas:'300000'});
    await contract.methods.register('niv','niv','1234').send({from:accounts[0],gas:'3000000'});
   
    //user 1 test
    await contract.methods.addPlayerToUser('niv','wade',2,3,4,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('niv','lebron',4,4,4,5,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('niv','cris',2,2,2,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('niv','blake',1,1,3,5,1).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('niv','daniel',4,10,3,2,5).send({from:accounts[0],gas:'3000000'});

    //user 2  test
    await contract.methods.addPlayerToUser('asafsuryano','wade',2,3,4,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('asafsuryano','lebron',4,4,4,5,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('asafsuryano','cris',2,2,2,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('asafsuryano','blake',1,1,3,5,1).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addPlayerToUser('asafsuryano','daniel',4,10,3,2,5).send({from:accounts[0],gas:'3000000'});


    //create gambller test
    await contract.methods.addUserGambling('niv',0).send({from:accounts[0],gas:'3000000'});
    await contract.methods.addUserGambling('asafsuryano',0).send({from:accounts[0],gas:'3000000'});
    

    
    //let battle=await contract.methods.getGamblingBattle(0).call();
    


    //finish battle test send each player statistic 
    //for gambller 1
    await contract.methods.calculateDayStatisticsOfPlayer(1,0,2,3,4,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(1,0,4,4,4,5,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(1,0,2,2,2,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(1,0,1,1,3,5,1).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(1,0,4,10,3,2,5).send({from:accounts[0],gas:'3000000'});
   
   

    //for gambller 2
    await contract.methods.calculateDayStatisticsOfPlayer(2,0,2,3,4,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(2,0,4,4,4,5,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(2,0,2,2,2,2,2).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(2,0,1,1,3,5,10).send({from:accounts[0],gas:'3000000'});
    await contract.methods.calculateDayStatisticsOfPlayer(2,0,4,10,3,2,5).send({from:accounts[0],gas:'3000000'});  
  
   
   //decide who win 

   let winnerSum=await contract.methods.winner(0).call() 
   //console.log("winner sum is"+winnerSum);
   console.log("there is a winner ",winnerSum);

}


createBattleTest();
