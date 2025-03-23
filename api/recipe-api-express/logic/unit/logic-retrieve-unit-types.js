'use strict';

const logicRetrieveUnitTypes = async (inputs) => {
    return { 
        data: { 
            unitTypes: [
                {
                    unitTypeName: 'Metric'
                },
                {
                    unitTypeName: 'Imperial'
                },
                {
                    unitTypeName: 'Natural'
                },
            ] 
        } 
    };
}

module.exports = logicRetrieveUnitTypes;