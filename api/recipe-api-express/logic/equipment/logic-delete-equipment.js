'use strict';

const getData = require('../../data/data-utils');

const logicDeleteEquipment = async (inputs) => {
    const params = { 
        procName: 'deleteEquipment', 
        procArgs: [
            { name: 'equipmentId', value: inputs.equipmentId }    
        ]
    };

    await getData(params);

    return;
}

module.exports = logicDeleteEquipment;