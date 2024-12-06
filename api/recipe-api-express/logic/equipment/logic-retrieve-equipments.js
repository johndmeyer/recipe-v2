'use strict';

const execProc = require('../../data/mssql-utils');
const buildJsonTree = require('../_baseLogic');

const logicRetrieveEquipments = async (inputs) => {
    const params = { procName: 'retrieveEquipments'};

    const recordsets = await execProc(params);

    const jsonTree = buildJsonTree(recordsets[0], 'equipment')

    return { data: { equipment: jsonTree } };
}

module.exports = logicRetrieveEquipments;