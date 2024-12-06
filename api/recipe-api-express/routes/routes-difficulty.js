const express = require('express');

const logicRetrieveDifficulties = require('../logic/difficulty/logic-retrieve-difficulties');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveDifficulties())
    } catch (err) {
        next(err);
    }    
});

module.exports = router;