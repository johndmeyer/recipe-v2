/*
Name: deleteRecipe
Useage: CALL deleteRecipe(6)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteRecipe;

DELIMITER //

CREATE PROCEDURE deleteRecipe(
	recipeId INT
)
BEGIN
	CALL deleteRecipeEquipments(recipeId);

	CALL deleteRecipeIngredients(recipeId);

	CALL deleteRecipeTags(recipeId);
		
	DELETE FROM
		recipe r
	WHERE
		r.recipeId = recipeId;
END //

DELIMITER ;