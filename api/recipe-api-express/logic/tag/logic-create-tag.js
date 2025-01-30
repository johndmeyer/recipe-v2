'use strict';

const getData = require('../../data/data-utils');

const logicCreateTag = async (inputs) => {
    const params = { 
        procName: 'createTag', 
        procArgs: [            
            { name: 'tagName', type: 'string', value: inputs.tagName },
            { name: 'tagParentId', value: inputs.tagParentId }
        ]
    };

    const recordsets = await getData(params);

    return { data: { tags: recordsets[0] } };
}

module.exports = logicCreateTag;