'use strict';

const getData = require('../../data/data-utils');

const logicRetrieveUnits = async (inputs) => {
    const params = { procName: 'retrieveUnits', procArgs: [{ name: 'unitType', value: inputs.unitType }] };

    const recordsets = await getData(params);

    return { data: { units: recordsets[0] } };
}

module.exports = logicRetrieveUnits;