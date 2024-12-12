'use strict';

const express = require('express');

const logicCreateIngredient = require('../logic/ingredient/logic-create-ingredient');
const logicRetrieveIngredients = require('../logic/ingredient/logic-retrieve-ingredients');
const logicUpdateIngredient = require('../logic/ingredient/logic-update-ingredient');

const router = express.Router();

router.get('/', async (req, res, next) => {
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