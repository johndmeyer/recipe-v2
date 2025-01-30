'use strict';

const express = require('express');

const logicCreateTag = require('../logic/tag/logic-create-tag');
const logicDeleteTag = require('../logic/tag/logic-delete_tag');
const logicRetrieveTags = require('../logic/tag/logic-retrieve-tags');
const logicUpdateTag = require('../logic/tag/logic-update-tag');

const router = express.Router();

/**
 * DELETE /tag/{tagId}
 * @summary Deletes an tag table entry and all entries in the recipe-tag table for a given tagId
 * @tags Tag
 * @param {integer} tagId.path.required
 * @return {object} 200 - Success response
*/
router.delete('/:tagId', async (req, res, next) => {
    try {
        const tagId = req.params.tagId; // TODO: handle bad input 

        res.send(await logicDeleteTag({ tagId }))
    } catch (err) {
        next(err);
    } 
});

/**
 * GET /tag
 * @summary Retrieves a hierarchical list of tags - used for drop down
 * @tags Tag
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     tags: [
 *       {
 *         tagId: 30,
 *         tagName: '30 minutes or less',
 *         tagParentId: 5
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveTags())
    } catch (err) {
        next(err);
    }    
});

/**
 * POST /tag
 * @summary Changes the name of a tag table entry
 * @tags Tag
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *   tagId: 5,
 *   tagName: 'Tag name here'
 * }
 * @example response - 200 - example success response
 * {
 *   data: {
 *     tags: [
 *       {
 *         tagId: 30,
 *         tagName: 'Savory',
 *         tagParentId: 5
 *       }
 *     ]
 *   } 
 * }
*/
router.post('/', async (req, res, next) => {
    try {
        const tagId = req.body.tagId; // TODO: handle bad input
        const tagName = req.body.tagName; // TODO: handle bad input        

        res.send(await logicUpdateTag({ tagId, tagName }))
    } catch (err) {
        next(err);
    }    
});

/**
 * PUT /tag
 * @summary Creates a new tag table entry
 * @tags Tag
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *   tagParentId: 5,
 *   tagName: 'Tag name here'   
 * }
 * @example response - 200 - example success response
 * {
 *   data: {
 *     tags: [
 *       {
 *         tagId: 30,
 *         tagName: 'Savory',
 *         tagParentId: 5
 *       }
 *     ]
 *   } 
 * }
*/
router.put('/', async (req, res, next) => {
    try {
        const tagName = decodeURI(req.body.tagName); // TODO: handle bad input
        const tagParentId = req.body.tagParentId ?? 0; // TODO: handle bad input        

        res.send(await logicCreateTag({ tagParentId, tagName }))
    } catch (err) {
        next(err);
    }    
});

module.exports = router;