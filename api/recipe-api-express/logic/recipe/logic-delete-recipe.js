'use strict';

const getData = require('../../data/data-utils');

const logicCreateEquipment = async (inputs) => {
    const params = { 
        procName: 'deleteRecipe', 
        procArgs: [
            { name: 'recipeId', value: inputs.recipeId }            
        ]
    };

    await getData(params);

    return;
}

module.exports = logicCreateEquipment;