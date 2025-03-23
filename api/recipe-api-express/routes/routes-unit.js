const express = require('express');

const logicRetrieveUnitTypes = require('../logic/unit/logic-retrieve-unit-types');
const logicRetrieveUnits = require('../logic/unit/logic-retrieve-units');

const router = express.Router();

/**
 * GET /unit
 * @summary Retrieves a list of unit types
 * @tags Unit
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     unitType: [
 *       {
 *         unitTypeName: 'metric'
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveUnitTypes())
    } catch (err) {
        next(err);
    }    
});

/**
 * GET /unit/{unitType}
 * @summary Retrieves a list of units of a given type
 * @tags Unit
 * @param {string} unitType.path - UnitType - indicates the type of units to return (e.g. metric, imperial, etc...). Units of natural type (e.g. whole, clove, etc...) are always returned. Defaults to 1 (metric).
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     unit: [
 *       {
 *         unitType: 'Metric',
 *         unitName: 'gram(s),
 *         unitAbbreviation: 'g'
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/:unitType', async (req, res, next) => {
    try {
        const unitType = req.params.unitType === '{unitType}' 
            ? 'Metric' 
            : req.params.unitType; // TODO: handle bad input

        res.send(await logicRetrieveUnits({ unitType }))
    } catch (err) {
        next(err);
    }    
});

module.exports = router;