'use strict';

const getData = require('../../data/data-utils');
// NOTE: It would be better to do this all in SQL as a transaction in case any one of these database saves fail.
// I'm using SQL Server 2008 here which does not support JSON parsing, however when I port the database to MySQL
// I should be able to do this more elegantly

// Ported to MySQL - I'll come back to this - want to get everything working first

const logicCreateRecipe = async (inputs) => {
    const recipe = inputs.recipe;
    const equipments = inputs.recipeEquipments;
    const ingredients = inputs.recipeIngredients;
    const tags = inputs.recipeTags;

    const recipeParams = { 
        procName: 'createRecipe', 
        procArgs: [
            { name: 'recipeDescription', type: 'string', value: recipe.recipeDescription },
            { name: 'recipeDifficultyId', value: recipe.recipeDifficultyId },
            { name: 'recipeDirections', type: 'string', value: recipe.recipeDirections },
            { name: 'recipeDuration', value: recipe.recipeDuration },
            { name: 'recipeName', type: 'string', value: recipe.recipeName },
            { name: 'recipePhotoUrl', type: 'string', value: recipe.recipePhotoUrl },
            { name: 'recipeYield', type: 'string', value: recipe.recipeYield },
        ]
    };

    const recordsets = await getData(recipeParams);

    const recipeId = recordsets[0][0].recipeId;

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

        await getData(ingredientParams);
    }

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

    return { data: { recipeId } };
}

module.exports = logicCreateRecipe;