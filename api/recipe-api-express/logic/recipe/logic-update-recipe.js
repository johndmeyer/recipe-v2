'use strict';

const execProc = require('../../data/mssql-utils');
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

    await execProc(recipeParams);

    // Delete all existing equipments
    await execProc({ procName: 'deleteRecipeEquipments', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] });
    
    // Re-add all new ingredients
    for (const equipment of equipments) {
        const equipmentParams = {
            procName: 'createRecipeEquipment',
            procArgs: [
                { name: 'recipeId', value: inputs.recipeId },
                { name: 'equipmentId', value: equipment.equipmentId}
            ]
        }

        await execProc(equipmentParams);
    }

    // Delete all existing ingredients
    await execProc({ procName: 'deleteRecipeIngredients', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] });

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

        await execProc(ingredientParams);
    }

    // Delete all existing tags
    await execProc({ procName: 'deleteRecipeTags', procArgs: [{ name: 'recipeId', value: inputs.recipeId }] });

    // Re-add all new tags
    for (const tag of tags) {
        const tagParams = {
            procName: 'createRecipeTag',
            procArgs: [
                { name: 'recipeId', value: inputs.recipeId },
                { name: 'tagId', value: tag.tagId}
            ]
        }

        await execProc(tagParams);
    }

    return { data: { recipeId: inputs.recipeId } };
}

module.exports = logicUpdateRecipe;