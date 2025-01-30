'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveUnits = async (inputs) => {
    const params = { procName: 'retrieveDifficulties' };

    const recordsets = await getData(params);

    return { data: { difficultys: recordsets[0] } };
}

module.exports = logicRetrieveUnits;