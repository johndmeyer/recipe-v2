'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { 
        procName: 'retrieveRecipes', 
        procArgs: [
            { name: 'recipeCookTime', value: inputs.cookTime },
            { name: 'recipeDifficultyId', value: inputs.difficultyId },
            { name: 'recipeTagId', value: inputs.tagId },
        ]  
    };

    const recordsets = await execProc(params);

    return {
        data: {
            recipe: recordsets[0]
        }
    }
}

module.exports = logicRetrieveRecipe;