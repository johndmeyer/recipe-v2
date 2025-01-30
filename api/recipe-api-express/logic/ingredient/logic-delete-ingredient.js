'use strict';

const getData = require('../../data/data-utils');

const logicDeleteIngredient = async (inputs) => {
    const params = { 
        procName: 'deleteIngredient', 
        procArgs: [
            { name: 'ingredientId', value: inputs.ingredientId }    
        ]
    };

    await getData(params);

    return;
}

module.exports = logicDeleteIngredient;