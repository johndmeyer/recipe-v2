'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { procName: 'retrieveRecipeEquipment', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] };

    const recordsets = await execProc(params);

    return { data: { recipeEquipments: recordsets[0] } };
}

module.exports = logicRetrieveRecipe;