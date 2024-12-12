'use strict';

const execProc = require('../../data/mssql-utils');

const logicCreateEquipment = async (inputs) => {
    const params = { 
        procName: 'deleteRecipe', 
        procArgs: [
            { name: 'recipeId', value: inputs.recipeId }            
        ]
    };

    await execProc(params);

    return;
}

module.exports = logicCreateEquipment;