'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveRecipeIngredients = async (inputs) => {
    const params = { procName: 'retrieveRecipeIngredients', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] };

    const recordsets = await execProc(params);

    return { data: { recipeIngredients: recordsets[0] } };
}

module.exports = logicRetrieveRecipeIngredients;