'use strict';

const execProc = require('../../data/mssql-utils');

const logicCreateTag = async (inputs) => {
    const params = { 
        procName: 'createTag', 
        procArgs: [            
            { name: 'tagParentId', value: inputs.tagParentId },
            { name: 'tagName', type: 'string', value: inputs.tagName }
        ]
    };

    const recordsets = await execProc(params);

    return { data: { tagId: recordsets[0][0].tagId } };
}

module.exports = logicCreateTag;