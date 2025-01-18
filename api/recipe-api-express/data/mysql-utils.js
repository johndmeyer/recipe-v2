'use strict';

// https://github.com/mysqljs/mysql
const mysql2 = require('mysql2');

const getConnection =  () => {
    const connection = mysql2.createConnection({
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'abc123',
        database: 'recipe',
        insecureAuth: true
    });

    return connection;
}

const buildQuery = (params) => {
    let query = `CALL ${params.procName}`;

    if (params.procArgs) {
        query = `${query}(`;

        let argCounter = 0;

        for (const arg of params.procArgs) {
            if (arg.value != undefined) {
                if (arg.type === 'string') { // TODO: Break this up so the logic isn't so dense
                    query = `${query}${argCounter !== 0 ? ',' : ''}'${arg.value}'`;
                } else {
                    query = `${query}${argCounter !== 0 ? ',' : ''}${arg.value}`;
                }
                
                argCounter++;
            }
        }

        query = `${query})`;
    }

    return query;
}

const callProc = async (params) => {   
    const query = buildQuery(params);    

    let dataSets = [];

    try
    {
        const connection =  getConnection();

        const [results] = await connection.promise().query(query);

        dataSets = results;
    }
    catch(ex) {
        const foo = ex;
        // TODO: implement error handling 
        // - just swallow exception for now
    }

    return dataSets;
}

module.exports = callProc;
