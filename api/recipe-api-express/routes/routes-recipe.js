const express = require('express');

const logicCreateRecipe = require('../logic/recipe/logic-create-recipe');
const logicRetrieveRecipe = require('../logic/recipe/logic-retrieve-recipe');
const logicRetrieveRecipes = require('../logic/recipe/logic-retrieve-recipes');
const logicRetrieveRecipeEquipments = require('../logic/recipe/logic-retrieve-recipe-equipments');
const logicRetrieveRecipeIngredients = require('../logic/recipe/logic-retrieve-recipe-ingredients');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        const { cookTime, difficultyId, tagId } = req.query; // TODO: handle bad input

        res.send(await logicRetrieveRecipes({ cookTime, difficultyId, tagId }));
    } catch (err) {
        next(err);
    }    
});

router.get('/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input

        res.send(await logicRetrieveRecipe({ recipeId }))
    } catch (err) {
        next(err);
    }    
});

router.get('/ingredients/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input

        res.send(await logicRetrieveRecipeIngredients({ recipeId }))
    } catch (err) {
        next(err);
    }    
});

router.get('/equipments/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input

        res.send(await logicRetrieveRecipeEquipments({ recipeId }))
    } catch (err) {
        next(err);
    }    
});

router.put('/', async (req, res, next) => {
    try {
        const { ...recipe } = req.body;

        res.send(await logicCreateRecipe({ recipe }));
    } catch (err) {
        next(err);
    }
});

module.exports = router;