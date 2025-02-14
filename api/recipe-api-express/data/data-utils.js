const execProc = require('./mssql-utils');
const callProc = require('./mysql-utils');
const mongoData = require('./mongo-utils');

/**
 * Wrapper for 3 different types of database calls
 * @param {object} params An object containing the name and arguments needed to obtain the data
 * @param {string} params.procName The name of the stored procedure to be called
 * @param {array} [params.procArgs] An array of objects containing the name, type, and value of each argument
 * @returns {Promise} Returns a promise that resolves to the data
 */
const getData = async (params) => {
    // TODO: Set this up to use an environment variable or something so we can easily switch from
    // sql server to mysql to mongo or whatever
    
    //return await execProc(params);
    //return await callProc(params);
    return await mongoData(params);
}

module.exports = getData;