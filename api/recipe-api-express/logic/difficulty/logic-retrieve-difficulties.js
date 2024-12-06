'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveUnits = async (inputs) => {
    const params = { procName: 'retrieveDifficulties' };

    const recordsets = await execProc(params);

    return { data: { difficultys: recordsets[0] } };
}

module.exports = logicRetrieveUnits;