'use strict';

const getData = require('../../data/data-utils');

const logicUpdateEquipment = async (inputs) => {
    const params = { 
        procName: 'updateEquipment', 
        procArgs: [
            { name: 'equipmentDescription', type: 'string', value: inputs.equipmentDescription },
            { name: 'equipmentId', value: inputs.equipmentId },
            { name: 'equipmentName', type: 'string', value: inputs.equipmentName }            
        ]
    };

    const recordsets = await getData(params);

    return { data: { equipments: recordsets[0]} };
}

module.exports = logicUpdateEquipment;