'use strict';

const express = require('express');

const logicCreateIngredient = require('../logic/ingredient/logic-create-ingredient');
const logicRetrieveIngredients = require('../logic/ingredient/logic-retrieve-ingredients');
const logicUpdateIngredient = require('../logic/ingredient/logic-update-ingredient');

const router = express.Router();

/**
 * DELETE /ingredient/{id}
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
 * GET /ingredient/{ingredientId}
 * @summary Retrieves a hierarchical list of equipment - used for drop down
 * @tags Equipment
 * @param {integer} ingredientId.path - IngredientId brings back a single ingredient if passed, if ommited returns a hierarchical list of  all equipment
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *     equipment: [
 *       {
 *         equipmentId: 30,
 *         equipmentName: '30 minutes or less',
 *         equipmentParentId: 5
 *       }
 *     ]
 *   }  
 * }
*/
router.get('/:ingredientId', async (req, res, next) => {
    try {
        res.send(await logicRetrieveIngredients())
    } catch (err) {
        next(err);
    }    
});

router.post('/:ingredientId/:ingredientName', async(req, res, next) => {
    try {
        const ingredientDescription = req.body.ingredientDescription; // TODO: handle bad input
        const ingredientId = req.params.ingredientId; // TODO: handle bad input
        const ingredientName = req.params.ingredientName; // TODO: handle bad input
        
        res.send(await logicUpdateIngredient({ ingredientDescription, ingredientId, ingredientName }));
    } catch (err) {
        next(err);
    }
});

router.put('/:ingredientName', async(req, res, next) => {
    try {
        const ingredientDescription = req.body.ingredientDescription; // TODO: handle bad input
        const ingredientName = req.params.ingredientName; // TODO: handle bad input

        res.send(await logicCreateIngredient({ ingredientDescription, ingredientName }))
    } catch (err) {
        next(err);
    }
});

router.put('/:ingredientParentId/:ingredientName', async(req, res, next) => {
    try {
        const ingredientDescription = req.body.ingredientDescription; // TODO: handle bad input
        const ingredientParentId = req.params.ingredientParentId; // TODO: handle bad input
        const ingredientName = req.params.ingredientName; // TODO: handle bad input

        res.send(await logicCreateIngredient({ ingredientDescription, ingredientParentId, ingredientName }))
    } catch (err) {
        next(err);
    }
});

module.exports = router;