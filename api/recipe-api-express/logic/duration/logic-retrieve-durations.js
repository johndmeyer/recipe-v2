'use strict';

const logicRetrieveDurations = async () => {
    return { 
        data: { 
            durations: [
                {
                    durationId: 30,
                    durationName: '30 minutes or less'
                },
                {
                    durationId: 60,
                    durationName: '60 minutes or less'
                },
                {
                    durationId: 90,
                    durationName: '90 minutes or less'
                }
            ] 
        } 
    };
}

module.exports = logicRetrieveDurations;