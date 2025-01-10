const express = require('express');

const logicCreateRecipe = require('../logic/recipe/logic-create-recipe');
const logicDeleteRecipe = require('../logic/recipe/logic-delete-recipe');
const logicRetrieveRecipe = require('../logic/recipe/logic-retrieve-recipe');
const logicRetrieveRecipes = require('../logic/recipe/logic-retrieve-recipes');
const logicRetrieveRecipeEquipments = require('../logic/recipe/logic-retrieve-recipe-equipments');
const logicRetrieveRecipeIngredients = require('../logic/recipe/logic-retrieve-recipe-ingredients');
const logicUpdateRecipe = require('../logic/recipe/logic-update-recipe');

const router = express.Router();

/**
 * DELETE /recipe/{recipeId}
 * @summary Deletes entry from the recipe table as well as associated entries in the ingredient, equipment, and tag tables
 * @tags Recipe
 * @param {integer} request.query.required - The id of the recipe to be deleted
*/
router.delete('/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input

        res.send(await logicDeleteRecipe({ recipeId }));
    } catch (err) {
        next(err);
    }    
});

router.get('/', async (req, res, next) => {
    try {
        const { cookTime, difficultyId, tagId } = req.query; // TODO: handle bad input

        res.send(await logicRetrieveRecipes({ cookTime, difficultyId, tagId }));
    } catch (err) {
        next(err);
    }    
});

/**
 * GET /recipe/{recipeId}
 * @summary Gets a recipe by id
 * @tags Recipe
 * @param {integer} request.query.required - The id of the recipe to be returned
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *   data: {
 *   
 *   } 
 * }
*/
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

router.post('/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input
        const { ...recipe } = req.body; // TODO: handle bad input

        res.send(await logicUpdateRecipe({ recipe, recipeId }));
    } catch (err) {
        next(err);
    }
});

module.exports = router;