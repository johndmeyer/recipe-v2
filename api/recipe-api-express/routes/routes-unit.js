const express = require('express');

const logicRetrieveUnitTypes = require('../logic/unit/logic-retrieve-unit-types');
const logicRetrieveUnits = require('../logic/unit/logic-retrieve-units');

const router = express.Router();

router.get('/types', async (req, res, next) => {
    try {
        res.send(await logicRetrieveUnitTypes())
    } catch (err) {
        next(err);
    }    
});

router.get('/:unitTypeName', async (req, res, next) => {
    try {
        const unitTypeName = req.params.unitTypeName; // TODO: handle bad input

        res.send(await logicRetrieveUnits({ unitTypeName }))
    } catch (err) {
        next(err);
    }    
});

module.exports = router;