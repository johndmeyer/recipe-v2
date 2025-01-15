'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { 
        procName: 'retrieveRecipes', 
        procArgs: [
            { name: 'recipeCookTime', value: inputs.cookTime },
            { name: 'recipeDifficultyId', value: inputs.difficultyId },
            { name: 'recipeTagId', value: inputs.tagId },
        ]  
    };

    const recordsets = await getData(params);

    return {
        data: {
            recipe: recordsets[0]
        }
    }
}

module.exports = logicRetrieveRecipe;