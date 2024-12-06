'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveRecipeTypes = async () => {
    const params = { procName: 'retrieveRecipeTypes' };

    const recordsets = await execProc(params);

    return { data: { recipeTypes: recordsets[0] } };
}

module.exports = logicRetrieveRecipeTypes;