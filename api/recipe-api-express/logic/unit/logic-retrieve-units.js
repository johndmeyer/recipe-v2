'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveUnits = async (inputs) => {
    const params = { procName: 'retrieveUnits', procArgs: [{ name: 'unitTypeName', value: inputs.unitTypeName }] };

    const recordsets = await execProc(params);

    return { data: { units: recordsets[0] } };
}

module.exports = logicRetrieveUnits;