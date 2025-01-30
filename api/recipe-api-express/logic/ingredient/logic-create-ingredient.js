'use strict';

const getData = require('../../data/data-utils');

const logicCreateIngredient = async (inputs) => {
    const params = { 
        procName: 'createIngredient', 
        procArgs: [
            { name: 'ingredientDescription', type: 'string', value: inputs.ingredientDescription },            
            { name: 'ingredientName', type: 'string', value: inputs.ingredientName },
            { name: 'ingredientParentId', value: inputs.ingredientParentId }          
        ]
    };

    const recordsets = await getData(params);

    return { data: { ingredients: recordsets[0] } };
}

module.exports = logicCreateIngredient;