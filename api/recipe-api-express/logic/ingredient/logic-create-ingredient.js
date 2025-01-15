'use strict';

const getData = require('../../data/data-utils');

const logicCreateIngredient = async (inputs) => {
    const params = { 
        procName: 'createIngredient', 
        procArgs: [
            { name: 'ingredientDescription', type: 'string', value: inputs.ingredientDescription },
            { name: 'ingredientParentId', value: inputs.ingredientParentId },
            { name: 'ingredientName', type: 'string', value: inputs.ingredientName }            
        ]
    };

    const recordsets = await getData(params);

    return { data: { tagId: recordsets[0][0].ingredientId } };
}

module.exports = logicCreateIngredient;