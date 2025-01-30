'use strict';

const getData = require('../../data/data-utils');
const buildJsonTree = require('../_baseLogic');

const logicRetrieveTags = async (inputs) => {
    const params = { procName: 'retrieveTags'};

    const recordsets = await getData(params);

    const jsonTree = buildJsonTree(recordsets[0], 'tag')

    return { data: { tags: jsonTree } };
}

module.exports = logicRetrieveTags;