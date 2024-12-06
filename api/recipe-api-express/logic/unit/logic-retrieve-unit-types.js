'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveUnitTypes = async (inputs) => {
    const params = { procName: 'retrieveUnitTypes' };

    const recordsets = await execProc(params);

    return { data: { unitTypes: recordsets[0] } };
}

module.exports = logicRetrieveUnitTypes;