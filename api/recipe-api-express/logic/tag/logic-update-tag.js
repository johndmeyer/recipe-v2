'use strict';

const getData = require('../../data/data-utils');

const logicUpdateTag = async (inputs) => {
    const params = { 
        procName: 'updateTag', 
        procArgs: [
            { name: 'tagId', value: inputs.tagId },
            { name: 'tagName', type: 'string', value: inputs.tagName }            
        ]
    };

    const recordsets = await getData(params);

    return { data: { tags: recordsets[0] } };
}

module.exports = logicUpdateTag;