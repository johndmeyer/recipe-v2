'use strict';

const execProc = require('../../data/mssql-utils');

const logicRetrieveUnits = async () => {
    return { 
        data: { 
            cookTimes: [
                {
                    cookTimeId: 30,
                    cookTimeName: '30 minutes or less'
                },
                {
                    cookTimeId: 60,
                    cookTimeName: '60 minutes or less'
                },
                {
                    cookTimeId: 90,
                    cookTimeName: '90 minutes or less'
                }
            ] 
        } 
    };
}

module.exports = logicRetrieveUnits;