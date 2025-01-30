'use strict';

const getData = require('../../data/data-utils');

const logicCreateEquipment = async (inputs) => {
    const params = { 
        procName: 'createEquipment', 
        procArgs: [
            { name: 'equipmentDescription', type: 'string', value: inputs.equipmentDescription },            
            { name: 'equipmentName', type: 'string', value: inputs.equipmentName },
            { name: 'equipmentParentId', value: inputs.equipmentParentId }    
        ]
    };

    const recordsets = await getData(params);

    return { data: { equipments: recordsets[0] } };
}

module.exports = logicCreateEquipment;