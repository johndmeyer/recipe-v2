const express = require('express');

const logicCreateRecipe = require('../logic/recipe/logic-create-recipe');
const logicDeleteRecipe = require('../logic/recipe/logic-delete-recipe');
const logicRetrieveRecipe = require('../logic/recipe/logic-retrieve-recipe');
const logicRetrieveRecipes = require('../logic/recipe/logic-retrieve-recipes');
const logicUpdateRecipe = require('../logic/recipe/logic-update-recipe');

const router = express.Router();

/**
 * DELETE /recipe/{recipeId}
 * @summary Deletes entry from the recipe table as well as associated entries in the ingredient, equipment, and tag tables
 * @tags Recipe
 * @param {integer} recipeId.query.required - The id of the recipe to be deleted
*/
router.delete('/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input

        res.send(await logicDeleteRecipe({ recipeId }));
    } catch (err) {
        next(err);
    }    
});

/**
 * GET /recipe
 * @summary Gets a list of recipes filtered by the query params
 * @tags Recipe
 * @param {integer} cookTime.query - The max cook time for recipes returned
 * @param {integer} difficultyId.query - The difficultyId for recipes returned 1, 2, or 3
 * @param {integer} tagId.query - A tagId to filter recipes
 * TODO: add pagination parameters
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *  data: {
 *   recipies: [
 *    {
 *     difficultyName: "Medium",
 *     difficultyId: 2,
 *     recipeCookTime: 60,
 *     recipeDescription: "A slightly spicy soup made with chicken, rice, and garbanzo beans",
 *     recipeDirections: "yada yada",
 *     recipeName: "Bowl of the Wife of Kit Carson",
 *     recipePhotoUrl: "https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg",
 *     recipeYield: 6
 *    }
 *   ]
 *  } 
 * }
*/
router.get('/', async (req, res, next) => {
    try {
        const { cookTime, difficultyId, tagId } = req.query; // TODO: handle bad input

        res.send(await logicRetrieveRecipes(cookTime, difficultyId, tagId))
    } catch (err) {
        next(err);
    }    
});

/**
 * GET /recipe/{recipeId}
 * @summary Gets a recipe by id
 * @tags Recipe
 * @param {integer} recipeId.path - The id of the recipe to be returned
 * TODO: add pagination parameters
 * @return {object} 200 - Success response
 * @example response - 200 - example success response
 * {
 *  data: {
 *   recipe: {
 *    difficultyName: "Medium",
 *    difficultyId: 2,
 *    recipeCookTime: 60,
 *    recipeDescription: "A slightly spicy soup made with chicken, rice, and garbanzo beans",
 *    recipeDirections: "yada yada",
 *    recipeName: "Bowl of the Wife of Kit Carson",
 *    recipePhotoUrl: "https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg",
 *    recipeYield: 6
 *   },
 *   recipeIngredients: [
 *    {
 *     quantity: 1,
 *     unitName: null,
 *     unitId: null,
 *     unitAbbreviation: null,
 *     ingredientId: 15,
 *     ingredientName: "Whole Chicken",
 *     ingredientDescription: "A raw whole chicken that has been gutted and de-feathered"
 *    }
 *   ],
 *   recipeEquipments: [
 *    {
 *     equipmentDescription: "A heat source upon which pots, pans or other vessels can be placed",
 *     equipmentId: 5,
 *     equipmentName: "Burner"
 *    }
 *   ],
 *   recipeTags": [
 *    {
 *     tagId: 5,
 *     tagName: "Savory"
 *    }
 *   ]
 *  }
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

/**
 * POST /recipe
 * @summary Used to edit a recipe and/or its ingredients, equipment, or tags
 * @tags Recipe
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
 * {
 *  recipe: {
 *   difficultyName: "Medium",
 *   difficultyId: 2,
 *   recipeCookTime: 60,
 *   recipeDescription: "A slightly spicy soup made with chicken, rice, and garbanzo beans",
 *   recipeDirections: "yada yada",
 *   recipeName: "Bowl of the Wife of Kit Carson",
 *   recipePhotoUrl: "https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg",
 *   recipeYield: 6
 *  },
 *  recipeIngredients: [
 *   {
 *    quantity: 1,
 *    unitName: null,
 *    unitId: null,
 *    unitAbbreviation: null,
 *    ingredientId: 15,
 *    ingredientName: "Whole Chicken",
 *    ingredientDescription: "A raw whole chicken that has been gutted and de-feathered"
 *   }
 *  ],
 *  recipeEquipments: [
 *   {
 *    equipmentDescription: "A heat source upon which pots, pans or other vessels can be placed",
 *    equipmentId: 5,
 *    equipmentName: "Burner"
 *   }
 *  ],
 *  recipeTags": [
 *   {
 *    tagId: 5,
 *    tagName: "Savory"
 *   }
 *  ]
 * }
 * @example response - 200 - example success response
 * {
 *  data: {
 *   recipe: {
 *    difficultyName: "Medium",
 *    difficultyId: 2,
 *    recipeCookTime: 60,
 *    recipeDescription: "A slightly spicy soup made with chicken, rice, and garbanzo beans",
 *    recipeDirections: "yada yada",
 *    recipeName: "Bowl of the Wife of Kit Carson",
 *    recipePhotoUrl: "https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg",
 *    recipeYield: 6
 *   },
 *   recipeIngredients: [
 *    {
 *     quantity: 1,
 *     unitName: null,
 *     unitId: null,
 *     unitAbbreviation: null,
 *     ingredientId: 15,
 *     ingredientName: "Whole Chicken",
 *     ingredientDescription: "A raw whole chicken that has been gutted and de-feathered"
 *    }
 *   ],
 *   recipeEquipments: [
 *    {
 *     equipmentDescription: "A heat source upon which pots, pans or other vessels can be placed",
 *     equipmentId: 5,
 *     equipmentName: "Burner"
 *    }
 *   ],
 *   recipeTags": [
 *    {
 *     tagId: 5,
 *     tagName: "Savory"
 *    }
 *   ]
 *  }
 * }
*/
router.post('/:recipeId', async (req, res, next) => {
    try {
        const recipeId = req.params.recipeId; // TODO: handle bad input
        const { ...recipe } = req.body; // TODO: handle bad input

        res.send(await logicUpdateRecipe({ recipe, recipeId }));
    } catch (err) {
        next(err);
    }
});

/**
 * PUT /recipe
 * @summary Creates a new ingredient table entry
 * @tags Recipe
 * @param {object} request.body.required
 * @return {object} 200 - Success response
 * @example request - example payload
* {
 *  recipe: {
 *   difficultyName: "Medium",
 *   difficultyId: 2,
 *   recipeCookTime: 60,
 *   recipeDescription: "A slightly spicy soup made with chicken, rice, and garbanzo beans",
 *   recipeDirections: "yada yada",
 *   recipeName: "Bowl of the Wife of Kit Carson",
 *   recipePhotoUrl: "https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg",
 *   recipeYield: 6
 *  },
 *  recipeIngredients: [
 *   {
 *    quantity: 1,
 *    unitName: null,
 *    unitId: null,
 *    unitAbbreviation: null,
 *    ingredientId: 15,
 *    ingredientName: "Whole Chicken",
 *    ingredientDescription: "A raw whole chicken that has been gutted and de-feathered"
 *   }
 *  ],
 *  recipeEquipments: [
 *   {
 *    equipmentDescription: "A heat source upon which pots, pans or other vessels can be placed",
 *    equipmentId: 5,
 *    equipmentName: "Burner"
 *   }
 *  ],
 *  recipeTags": [
 *   {
 *    tagId: 5,
 *    tagName: "Savory"
 *   }
 *  ]
 * }
 * @example response - 200 - example success response
 * {
 *  data: {
 *   recipe: {
 *    difficultyName: "Medium",
 *    difficultyId: 2,
 *    recipeCookTime: 60,
 *    recipeDescription: "A slightly spicy soup made with chicken, rice, and garbanzo beans",
 *    recipeDirections: "yada yada",
 *    recipeName: "Bowl of the Wife of Kit Carson",
 *    recipePhotoUrl: "https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg",
 *    recipeYield: 6
 *   },
 *   recipeIngredients: [
 *    {
 *     quantity: 1,
 *     unitName: null,
 *     unitId: null,
 *     unitAbbreviation: null,
 *     ingredientId: 15,
 *     ingredientName: "Whole Chicken",
 *     ingredientDescription: "A raw whole chicken that has been gutted and de-feathered"
 *    }
 *   ],
 *   recipeEquipments: [
 *    {
 *     equipmentDescription: "A heat source upon which pots, pans or other vessels can be placed",
 *     equipmentId: 5,
 *     equipmentName: "Burner"
 *    }
 *   ],
 *   recipeTags": [
 *    {
 *     tagId: 5,
 *     tagName: "Savory"
 *    }
 *   ]
 *  }
 * }
*/
router.put('/', async (req, res, next) => {
    try {
        const { ...recipe } = req.body;

        res.send(await logicCreateRecipe({ recipe }));
    } catch (err) {
        next(err);
    }
});

module.exports = router;