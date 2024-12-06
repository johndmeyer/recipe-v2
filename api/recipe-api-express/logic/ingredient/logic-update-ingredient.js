'use strict';

const execProc = require('../../data/mssql-utils');

const logicUpdateIngredient = async (inputs) => {
    const params = { 
        procName: 'updateIngredient', 
        procArgs: [
            { name: 'ingredientDescription', type: 'string', value: inputs.ingredientDescription },
            { name: 'ingredientParentId', value: inputs.ingredientParentId },
            { name: 'ingredientName', type: 'string', value: inputs.ingredientName }            
        ]
    };

    const recordsets = await execProc(params);

    return { data: { tagId: recordsets[0][0].ingredientId } };
}

module.exports = logicUpdateIngredient;