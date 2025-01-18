/*
Name: deleteRecipeIngredients
Useage: CALL deleteRecipeIngredients(5)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteRecipeIngredients;

DELIMITER //

CREATE PROCEDURE deleteRecipeIngredients(
	recipeId INT
)
BEGIN
	DELETE FROM
		recipe_ingredient ri
	WHERE
		ri.recipeId = recipeId;
END //

DELIMITER ;





