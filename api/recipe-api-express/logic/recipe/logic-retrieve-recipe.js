'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { procName: 'retrieveRecipe', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] };

    const recordsets = await execProc(params);

    return {
        data: {
            recipe: recordsets[0][0],
            recipeIngredients: recordsets[1],
            recipeEquipments: recordsets[2],
            recipeTags: recordsets[3]
        }
    }
}

module.exports = logicRetrieveRecipe;