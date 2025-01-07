const express = require('express');

const logicRetrieveDifficulties = require('../logic/difficulty/logic-retrieve-difficulties');

const router = express.Router();

/**
 * GET /difficulty/
 * @summary Retrieves a list of difficulties - used for drop down
 * @tags Difficulty
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *	   difficulties: [
 *       {
 *	       difficultyId: 30,
 *         difficultyName: '30 minutes or less'
 *       }
 *     ]
 *   }	
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveDifficulties())
    } catch (err) {
        next(err);
    }    
});

module.exports = router;