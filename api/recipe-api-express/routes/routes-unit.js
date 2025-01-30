const express = require('express');

const logicRetrieveUnitTypes = require('../logic/unit/logic-retrieve-unit-types');
const logicRetrieveUnits = require('../logic/unit/logic-retrieve-units');

const router = express.Router();

/**
 * GET /unit/type
 * @summary Retrieves a list of unit types
 * @tags Unit
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     unitType: [
 *       {
 *         unitTypeId: 1,
 *         unitTypeName: 'metric'
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/types', async (req, res, next) => {
    try {
        res.send(await logicRetrieveUnitTypes())
    } catch (err) {
        next(err);
    }    
});

/**
 * GET /unit/{unitTypeId}
 * @summary Retrieves a list of units of a given type
 * @tags Unit
 * @param {integer} unitTypeId.path - UnitTypeId - indicates the type of units to return (e.g. metric, imperial, etc...). Units of natural type (e.g. whole, clove, etc...) are always returned. Defaults to 1 (metric).
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     unit: [
 *       {
 *         unitId: 31,
 *         unitTypeId: 1,
 *         unitName: 'gram(s),
 *         unitAbbreviation: 'g'
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/:unitTypeId', async (req, res, next) => {
    try {
        const unitTypeId = req.params.unitTypeId; // TODO: handle bad input

        res.send(await logicRetrieveUnits({ unitTypeId }))
    } catch (err) {
        next(err);
    }    
});

module.exports = router;