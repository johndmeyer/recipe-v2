'use strict';

const logicRetrieveUnits = async (inputs) => {
    return { 
        data: { 
            difficultys: [
                {
                    difficultyId: 1,
                    difficultyName: 'Easy'
                },
                {
                    difficultyId: 2,
                    difficultyName: 'Meduim'
                },
                {
                    difficultyId: 3,
                    difficultyName: 'Hard'
                },
            ] 
        } 
    };
}

module.exports = logicRetrieveUnits;