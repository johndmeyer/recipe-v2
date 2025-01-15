'use strict';

const getData = require('../../data/data-utils');

const logicCreateTag = async (inputs) => {
    const params = { 
        procName: 'createTag', 
        procArgs: [            
            { name: 'tagParentId', value: inputs.tagParentId },
            { name: 'tagName', type: 'string', value: inputs.tagName }
        ]
    };

    const recordsets = await getData(params);

    return { data: { tagId: recordsets[0][0].tagId } };
}

module.exports = logicCreateTag;