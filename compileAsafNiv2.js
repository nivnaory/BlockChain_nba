const path = require('path');
const fs = require('fs-extra');
const solc = require('solc');

const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);

const profilePath = path.resolve(__dirname, 'contracts', 'main.sol');

const profileSource = fs.readFileSync(profilePath, 'UTF-8');

const profileOutput = solc.compile(profileSource, 1).contracts[':'+ 'NBA_gembller'];

fs.ensureDirSync(buildPath);


for (let contract in profileOutput) {
    fs.outputJSONSync(path.resolve(buildPath, contract.replace(':', '') + '.json'), profileOutput[contract]);
}
