'use strict';

const sql = require('mssql');

const getConnection = async () => {
    await sql.connect('Server=localhost,1433;Database=recipe;User Id=sa;Password=b0uld3r;Encrypt=false');

    return;
}

const execProc = async (params) => {
    await getConnection();

    let query = `EXEC ${params.procName}`;

    if (params.procArgs) {
        for (const [index, arg] of params.procArgs.entries()) {
            if (arg.value) {
                if (arg.type === 'string') { // TODO: Break this up so the logic isn't so dense
                    query = `${query}${index !== 0 ? ' ,' : ' '}@${arg.name}='${arg.value}'`;
                } else {
                    query = `${query}${index !== 0 ? ' ,' : ' '}@${arg.name}=${arg.value}`;
                }                
            }
        }
    }

    const result = await sql.query(query)

    return result.recordsets;
}

module.exports = execProc;
