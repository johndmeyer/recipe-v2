'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { 
        procName: 'retrieveRecipes', 
        procArgs: [
            { name: 'recipeDifficultyId', value: inputs.difficultyId },
            { name: 'recipeDuration', value: inputs.duration },            
            { name: 'recipeTagId', value: inputs.tagId }
        ]  
    };

    const recordsets = await getData(params);

    return {
        data: {
            recipes: recordsets[0]
        }
    }
}

module.exports = logicRetrieveRecipe;