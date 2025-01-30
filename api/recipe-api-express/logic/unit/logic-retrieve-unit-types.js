'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveUnitTypes = async (inputs) => {
    const params = { procName: 'retrieveUnitTypes' };

    const recordsets = await getData(params);

    return { data: { unitTypes: recordsets[0] } };
}

module.exports = logicRetrieveUnitTypes;