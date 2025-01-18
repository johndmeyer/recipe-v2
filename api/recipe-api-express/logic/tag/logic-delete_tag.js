'use strict';

const getData = require('../../data/data-utils');

const logicDeleteTag = async (inputs) => {
    const params = { 
        procName: 'deleteTag', 
        procArgs: [
            { name: 'tagId', value: inputs.tagId }    
        ]
    };

    await getData(params);

    return;
}

module.exports = logicDeleteTag;