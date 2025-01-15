'use strict';

const getData = require('../../data/data-utils');
// NOTE: It would be better to do this all in SQL as a transaction in case any one of these database saves fail.
// I'm using SQL Server 2008 here which does not support JSON parsing, however when I port the database to MySQL
// I should be able to do this more elegantly

const logicUpdateRecipe = async (inputs) => {
    const recipe = inputs.recipe.recipe;
    const equipments = inputs.recipe.equipments;
    const ingredients = inputs.recipe.ingredients;
    const tags = inputs.recipe.tags;

    const recipeParams = { 
        procName: 'updateRecipe', 
        procArgs: [
            { name: 'difficultyId', value: recipe.recipeDifficulty },	
            { name: 'recipeCookTime', value: recipe.recipeCookTime },
            { name: 'recipeDescription', type: 'string', value: recipe.recipeDescription },
            { name: 'recipeDirections', type: 'string', value: recipe.recipeDirections },
            { name: 'recipeId', value: inputs.recipeId },
            { name: 'recipeName', type: 'string', value: recipe.recipeName }, 
            { name: 'recipePhotoUrl', type: 'string', value: recipe.recipePhotoUrl },
            { name: 'recipeYield', type: 'string', value: recipe.recipeYield },
        ]
    };

    await getData(recipeParams);

    // Delete all existing equipments
    await getData({ procName: 'deleteRecipeEquipments', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] });
    
    // Re-add all new ingredients
    for (const equipment of equipments) {
        const equipmentParams = {
            procName: 'createRecipeEquipment',
            procArgs: [
                { name: 'recipeId', value: inputs.recipeId },
                { name: 'equipmentId', value: equipment.equipmentId}
            ]
        }

        await getData(equipmentParams);
    }

    // Delete all existing ingredients
    await getData({ procName: 'deleteRecipeIngredients', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] });

    // Re-add all new ingredients
    for (const ingredient of ingredients) {
        const ingredientParams = {
            procName: 'createRecipeIngredient',
            procArgs: [
                { name: 'recipeId', value: inputs.recipeId },
                { name: 'ingredientId', value: ingredient.ingredientId },
                { name: 'unitId', value: ingredient.unitId },
                { name: 'quantity', value: ingredient.quantity },
            ]
        }

        await getData(ingredientParams);
    }

    // Delete all existing tags
    await getData({ procName: 'deleteRecipeTags', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] });

    // Re-add all new tags
    for (const tag of tags) {
        const tagParams = {
            procName: 'createRecipeTag',
            procArgs: [
                { name: 'recipeId', value: inputs.recipeId },
                { name: 'tagId', value: tag.tagId}
            ]
        }

        await getData(tagParams);
    }

    return { data: { recipeId: inputs.recipeId } };
}

module.exports = logicUpdateRecipe;