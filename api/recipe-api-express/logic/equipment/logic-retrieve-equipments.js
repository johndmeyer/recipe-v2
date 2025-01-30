'use strict';

const getData = require('../../data/data-utils');
const buildJsonTree = require('../_baseLogic');

const logicRetrieveEquipments = async (inputs) => {
    const params = { procName: 'retrieveEquipments'};

    const recordsets = await getData(params);

    const jsonTree = buildJsonTree(recordsets[0], 'equipment')

    return { data: { equipment: jsonTree } };
}

module.exports = logicRetrieveEquipments;