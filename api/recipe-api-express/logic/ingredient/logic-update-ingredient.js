'use strict';

const getData = require('../../data/data-utils');

const logicUpdateIngredient = async (inputs) => {
    const params = { 
        procName: 'updateIngredient', 
        procArgs: [
            { name: 'ingredientDescription', type: 'string', value: inputs.ingredientDescription },
            { name: 'ingredientId', value: inputs.ingredientId },
            { name: 'ingredientName', type: 'string', value: inputs.ingredientName }                               
        ]
    };

    const recordsets = await getData(params);

    return { data: { ingredients: recordsets[0] } };
}

module.exports = logicUpdateIngredient;