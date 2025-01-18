const express = require('express');

const logicRetrieveCookTimes = require('../logic/cookTime/logic-retrieve-cookTimes');

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
 *	   cookTimeId: 30,
 *     cookTimeName: '30 minutes or less'
 *    }
 *   ]	
 *  }
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveCookTimes())
    } catch (err) {
        next(err);
    }    
});

module.exports = router;