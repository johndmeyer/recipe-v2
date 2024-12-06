const express = require('express');

const logicRetrieveCookTimes = require('../logic/cookTime/logic-retrieve-cookTimes');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveCookTimes())
    } catch (err) {
        next(err);
    }    
});

module.exports = router;