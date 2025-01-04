/*
Name: retrieveIngredients
Useage: CALL retrieveRecipe(1)
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveRecipe;

DELIMITER //

CREATE PROCEDURE retrieveRecipe (
	recipeId INT
)
BEGIN
	SELECT
		d.difficultyName,
		r.difficultyId,
		r.recipeCookTime,
		r.recipeDescription,
		r.recipeDirections,
		r.recipeName,
		r.recipePhotoUrl,
		r.recipeYield
	FROM
		recipe.recipe AS r
		LEFT OUTER JOIN
		difficulty AS d
			ON r.difficultyId = d.difficultyId
	WHERE
		r.recipeId = recipeId;
        
        CALL retrieveRecipeIngredients(recipeId);
        
        CALL retrieveRecipeEquipments(recipeId);

		CALL retrieveRecipeTags(recipeId);
        
END //

DELIMITER ;






