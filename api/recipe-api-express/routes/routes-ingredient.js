'use strict';

const express = require('express');

const logicCreateIngredient = require('../logic/ingredient/logic-create-ingredient');
const logicRetrieveIngredients = require('../logic/ingredient/logic-retrieve-ingredients');
const logicUpdateIngredient = require('../logic/ingredient/logic-update-ingredient');

const router = express.Router();

/**
 * DELETE /ingredient/{ingredientId}
 * @summary Deletes an ingredient table entry and all entries in the recipe-ingredient table for a given ingredientId
 * @tags Ingredient
 * @param {integer} ingredientId.path.required
 * @return {object} 200 - Success response
*/
router.delete('/:ingredientId', async (req, res, next) => {
    try {
        res.send('Sorry not yet implemented')
    } catch (err) {
        next(err);
    } 
});

/**
 * GET /ingredient
 * @summary Retrieves a hierarchical list of ingredients - used for drop down
 * @tags Ingredient
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *  data: {
 *   ingredients: [
 *    {
 *     ingredientId: 1,
 *     ingredientName: 'Basic',
 *     ingredientParentId: null,
 *     ingredientDescription: "A type reserved for the most basic of ingredients (e.g. Water)",
 *     ingredientPhotoUrl: null,
 *     items: [
 *      {
 *       ingredientId: 7,
 *       ingredientName: 'Water',
 *       ingredientParentId: 1,
 *       ingredientDescription: "Perhaps the most basic ingredient",
 *       ingredientPhotoUrl: null,
 *       items: []
 *      }
 *     ]
 *    }
 *   ]
 *  }  
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        res.send(await logicRetrieveIngredients())
    } catch (err) {
        next(err);
    }    
});

/**
 * POST /ingredient
 * @summary Changes the name and/or description of an ingredient table entry
 * @tags Ingredient
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *   ingredientId: 5,
 *   ingredientName: 'Ingredient name here'
 *   ingredientDescription: 'Ingredient description here'   
 * }
 * @example response - 200 - example success response
 * {
 *   data: {
 *     ingredient: [
 *       {
 *         ingredientId: 30,
 *         ingredientName: 'Chicken',
 *         ingredientParentId: 5,
 *         ingredientDescription: 'Quack, no, wait, Cock a doodle do, yeah that's it'
 *       }
 *     ]
 *   } 
 * }
*/
router.post('/', async(req, res, next) => {
    try {
        const ingredientDescription = req.body.ingredientDescription; // TODO: handle bad input
        const ingredientId = req.body.ingredientId; // TODO: handle bad input
        const ingredientName = req.body.ingredientName; // TODO: handle bad input
        
        res.send(await logicUpdateIngredient({ ingredientDescription, ingredientId, ingredientName }));
    } catch (err) {
        next(err);
    }
});

/**
 * PUT /ingredient
 * @summary Creates a new ingredient table entry
 * @tags Ingredient
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *   ingredientParentId: 5,
 *   ingredientName: 'Ingredient name here'
 *   ingredientDescription: 'Ingredient description here'      
 * }
 * @example response - 200 - example success response
 * {
 *   data: {
 *     ingredient: [
 *       {
 *         ingredientId: 30,
 *         ingredientName: '30 minutes or less',
 *         ingredientParentId: 5,
 *         ingredientDescription: 'Quack, no, wait, Cock a doodle do, yeah that's it'
 *       }
 *     ]
 *   } 
 * }
*/
router.put('/', async(req, res, next) => {
    try {
        const ingredientDescription = req.body.ingredientDescription; // TODO: handle bad input
        const ingredientName = req.body.ingredientName; // TODO: handle bad input
        const ingredientParentId = req.body.equipmentParentId; // TODO: handle bad input

        res.send(await logicCreateIngredient({ ingredientDescription, ingredientName, ingredientParentId }))
    } catch (err) {
        next(err);
    }
});

module.exports = router;