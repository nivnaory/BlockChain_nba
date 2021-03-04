const path = require('path');
const fs = require('fs-extra');
const solc = require('solc');

// ////////////##### only node deploy ######////////////////
const mainPath = path.resolve(__dirname, 'contracts', 'main.sol');
const source = fs.readFileSync(mainPath, 'utf8');


module.exports = solc.compile(source, 1).contracts[':NBAContract'];