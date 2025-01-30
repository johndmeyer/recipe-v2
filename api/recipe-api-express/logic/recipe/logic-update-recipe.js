'use strict';

const getData = require('../../data/data-utils');
// NOTE: It would be better to do this all in SQL as a transaction in case any one of these database saves fail.
// I'm using SQL Server 2008 here which does not support JSON parsing, however when I port the database to MySQL
// I should be able to do this more elegantly

// Ported to MySQL - I'll come back to this - want to get everything working first

const logicUpdateRecipe = async (inputs) => {
    const recipeId = inputs.recipe.recipeId;
    const recipe = inputs.recipe;
    const equipments = inputs.recipeEquipments;
    const ingredients = inputs.recipeIngredients;
    const tags = inputs.recipeTags;

    const recipeParams = { 
        procName: 'updateRecipe', 
        procArgs: [
            { name: 'recipeDescription', type: 'string', value: recipe.recipeDescription },
            { name: 'recipeDifficultyId', value: recipe.recipeDifficultyId },	
            { name: 'recipeDirections', type: 'string', value: recipe.recipeDirections },
            { name: 'recipeDuration', value: recipe.recipeDuration },
            { name: 'recipeId', value: recipeId },
            { name: 'recipeName', type: 'string', value: recipe.recipeName }, 
            { name: 'recipePhotoUrl', type: 'string', value: recipe.recipePhotoUrl },
            { name: 'recipeYield', type: 'string', value: recipe.recipeYield },
        ]
    };

    await getData(recipeParams);

    // Delete all existing equipments
    await getData({ procName: 'deleteRecipeEquipments', procArgs: [{ name: 'recipeId', value: recipeId }] });
    
    // Re-add all new ingredients
    for (const equipment of equipments) {
        const equipmentParams = {
            procName: 'createRecipeEquipment',
            procArgs: [
                { name: 'recipeId', value: recipeId },
                { name: 'equipmentId', value: equipment.equipmentId}
            ]
        }

        await getData(equipmentParams);
    }

    // Delete all existing ingredients
    await getData({ procName: 'deleteRecipeIngredients', procArgs: [{ name: 'recipeId', value: recipeId }] });

    // Re-add all new ingredients
    for (const ingredient of ingredients) {
        const ingredientParams = {
            procName: 'createRecipeIngredient',
            procArgs: [
                { name: 'recipeId', value: recipeId },
                { name: 'ingredientId', value: ingredient.ingredientId },
                { name: 'unitId', value: ingredient.unitId ?? 0 }, // TODO: remove the ?? 0 when input validation is complete
                { name: 'quantity', value: ingredient.quantity },
            ]
        }

        await getData(ingredientParams);
    }

    // Delete all existing tags
    await getData({ procName: 'deleteRecipeTags', procArgs: [{ name: 'recipeId', value: recipeId }] });

    // Re-add all new tags
    for (const tag of tags) {
        const tagParams = {
            procName: 'createRecipeTag',
            procArgs: [
                { name: 'recipeId', value: recipeId },
                { name: 'tagId', value: tag.tagId}
            ]
        }

        await getData(tagParams);
    }

    return { data: { recipeId: recipeId } };
}

module.exports = logicUpdateRecipe;