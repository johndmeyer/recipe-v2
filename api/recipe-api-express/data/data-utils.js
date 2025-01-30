const execProc = require('./mssql-utils');
const callProc = require('./mysql-utils');

const getData = async (params) => {
    // TODO: Set this up to use an environment variable or something so we can easily switch from
    // sql server to mysql to mongo or whatever
    
    //return await execProc(params);
    return await callProc(params);
}

module.exports = getData;