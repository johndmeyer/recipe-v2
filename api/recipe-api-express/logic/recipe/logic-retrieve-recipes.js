'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveRecipe = async (inputs) => {
    const params = { procName: 'retrieveRecipes' };

    const recordsets = await execProc(params);

    return {
        data: {
            recipe: recordsets[0]
        }
    }
}

module.exports = logicRetrieveRecipe;