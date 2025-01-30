'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { procName: 'retrieveRecipe', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] };

    const recordsets = await getData(params);

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