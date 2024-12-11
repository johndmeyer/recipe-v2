'use strict';

const execProc = require('../../data/mssql-utils');
// NOTE: It would be better to do this all in SQL as a transaction in case any one of these database saves fail...

const logicCreateRecipe = async (inputs) => {
    const recipe = inputs.recipe.recipe;
    const equipments = inputs.recipe.equipments;
    const ingredients = inputs.recipe.ingredients;
    const tags = inputs.recipe.tags;

    const recipeParams = { 
        procName: 'createRecipe', 
        procArgs: [
            { name: 'difficultyId', value: recipe.recipeDifficulty },	
            { name: 'recipeCookTime', value: recipe.recipeCookTime },
            { name: 'recipeDescription', type: 'string', value: recipe.recipeDescription },
            { name: 'recipeDirections', type: 'string', value: recipe.recipeDirections },
            { name: 'recipeName', type: 'string', value: recipe.recipeName },
            { name: 'recipePhotoUrl', type: 'string', value: recipe.recipePhotoUrl },
            { name: 'recipeYield', type: 'string', value: recipe.recipeYield },
        ]
    };

    const recordsets = await execProc(recipeParams);

    const recipeId = recordsets[0][0].recipeId;

    for (const ingredient of ingredients) {
        const ingredientParams = {
            procName: 'createRecipeIngredient',
            procArgs: [
                { name: 'recipeId', value: recipeId },
                { name: 'ingredientId', value: ingredient.ingredientId },
                { name: 'unitId', value: ingredient.unitId },
                { name: 'quantity', value: ingredient.quantity },
            ]
        }

        await execProc(ingredientParams);
    }

    for (const equipment of equipments) {
        const equipmentParams = {
            procName: 'createRecipeEquipment',
            procArgs: [
                { name: 'recipeId', value: recipeId },
                { name: 'equipmentId', value: equipment.equipmentId}
            ]
        }

        await execProc(equipmentParams);
    }

    for (const tag of tags) {
        const tagParams = {
            procName: 'createRecipeTag',
            procArgs: [
                { name: 'recipeId', value: recipeId },
                { name: 'tagId', value: tag.tagId}
            ]
        }

        await execProc(tagParams);
    }

    return { data: { recipeId } };
}

module.exports = logicCreateRecipe;