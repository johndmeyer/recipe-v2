'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveUnits = async (inputs) => {
    const params = { procName: 'retrieveUnits', procArgs: [{ name: 'unitTypeId', value: inputs.unitTypeId }] };

    const recordsets = await getData(params);

    return { data: { units: recordsets[0] } };
}

module.exports = logicRetrieveUnits;