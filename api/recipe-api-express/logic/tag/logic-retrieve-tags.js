'use strict';

const execProc = require('../../data/mssql-utils');
const buildJsonTree = require('../_baseLogic');

const logicRetrieveTags = async (inputs) => {
    const params = { procName: 'retrieveTags'};

    const recordsets = await execProc(params);

    const jsonTree = buildJsonTree(recordsets[0], 'tag')

    return { data: { tag: jsonTree } };
}

module.exports = logicRetrieveTags;