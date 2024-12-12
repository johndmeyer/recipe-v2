'use strict';

const execProc = require('../../data/mssql-utils');

const logicCreateEquipment = async (inputs) => {
    const params = { 
        procName: 'createEquipment', 
        procArgs: [
            { name: 'equipmentDescription', type: 'string', value: inputs.equipmentDescription },
            { name: 'equipmentParentId', value: inputs.equipmentParentId },
            { name: 'equipmentName', type: 'string', value: inputs.equipmentName }            
        ]
    };

    const recordsets = await execProc(params);

    return { data: { tagId: recordsets[0][0].equipmentId } };
}

module.exports = logicCreateEquipment;