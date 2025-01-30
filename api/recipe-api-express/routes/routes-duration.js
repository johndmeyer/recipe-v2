const express = require('express');

const logicRetrieveDurations = require('../logic/duration/logic-retrieve-durations');

const router = express.Router();
/**
 * GET /duration
 * @summary Retrieves a list of maximum cook times - used for drop down
 * @tags Duration
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *  data: {
 *   durations: [
 *    {
 *	   durationId: 30,
 *     durationName: '30 minutes or less'
 *    }
 *   ]	
 *  }
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveDurations())
    } catch (err) {
        next(err);
    }    
});

module.exports = router;