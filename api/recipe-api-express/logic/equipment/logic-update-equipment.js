'use strict';

const getData = require('../../data/data-utils');

const logicUpdateEquipment = async (inputs) => {
    const params = { 
        procName: 'updateEquipment', 
        procArgs: [
            { name: 'equipmentDescription', type: 'string', value: inputs.equpmentDescription },
            { name: 'equipmentParentId', value: inputs.equipmentParentId },
            { name: 'equipmentName', type: 'string', value: inputs.equipmentName }            
        ]
    };

    const recordsets = await getData(params);

    return { data: { tagId: recordsets[0][0].equipmentId } };
}

module.exports = logicUpdateEquipment;