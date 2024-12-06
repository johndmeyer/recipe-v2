'use strict';

const express = require('express');

const logicCreateTag = require('../logic/tag/logic-create-tag');
const logicRetrieveTags = require('../logic/tag/logic-retrieve-tags');
const logicUpdateTag = require('../logic/tag/logic-update-tag');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveTags())
    } catch (err) {
        next(err);
    }    
});

router.post('/:tagId/:tagName', async (req, res, next) => {
    try {
        const tagId = req.params.tagId; // TODO: handle bad input
        const tagName = req.params.tagName; // TODO: handle bad input        

        res.send(await logicUpdateTag({ tagId, tagName }))
    } catch (err) {
        next(err);
    }    
});

router.put('/:tagId/:tagName', async (req, res, next) => {
    try {
        const tagId = req.params.tagId; // TODO: handle bad input
        const tagName = decodeURI(req.params.tagName); // TODO: handle bad input

        res.send(await logicCreateTag({ tagId, tagName }))
    } catch (err) {
        next(err);
    }    
});

router.put('/:tagParentId/:tagName', async (req, res, next) => {
    try {
        const tagName = req.params.tagName; // TODO: handle bad input
        const tagParentId = req.params.tagParentId; // TODO: handle bad input

        res.send(await logicCreateTag({ tagName, tagParentId }))
    } catch (err) {
        next(err);
    }    
});



module.exports = router;