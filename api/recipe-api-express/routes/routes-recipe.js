const express = require('express');

const logicRetrieveRecipe = require('../logic/recipe/logic-retrieve-recipe');
const logicRetrieveRecipes = require('../logic/recipe/logic-retrieve-recipes');
const logicRetrieveRecipeTypes = require('../logic/recipe/logic-retrieve-recipe-types');
const logicRetrieveRecipeEquipments = require('../logic/recipe/logic-retrieve-recipe-equipments');
const logicRetrieveRecipeIngredients = require('../logic/recipe/logic-retrieve-recipe-ingredients');

const router = express.Router();

router.get('/', async (req, res, next) => {
    try {
        //const { recipeTypeId, recipeMaxCookTime, recipeCusineTypeId } = req.query; // TODO: handle bad input

        //res.send(await logicRetrieveRecipes({ recipeTypeId, recipeMaxCookTime, recipeCusineTypeId }));
        res.send(await logicRetrieveRecipes());
    } catch (err) {
        next(err);
    }    
});

router.get('/types', async (req, res, next) => {
    try {
        res.send(await logicRetrieveRecipeTypes())
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

module.exports = router;