'use strict';

const getData = require('../../data/data-utils');

const logicUpdateTag = async (inputs) => {
    const params = { 
        procName: 'updateTag', 
        procArgs: [
            { name: 'tagName', value: inputs.tagName },
            { name: 'tagId', value: inputs.tagId }
        ]
    };

    const recordsets = await getData(params);

    return { data: { tagId: recordsets[0][0].tagId } };
}

module.exports = logicUpdateTag;