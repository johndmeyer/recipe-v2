'use strict';

const getData = require('../../data/data-utils');
const buildJsonTree = require('../_baseLogic');

const logicRetrieveIngredients = async (inputs) => {
    const params = { procName: 'retrieveIngredients' };

    const recordsets = await getData(params);

    const jsonTree = buildJsonTree(recordsets[0], 'ingredient')

    return { data: { ingredient: jsonTree } };
}

module.exports = logicRetrieveIngredients;