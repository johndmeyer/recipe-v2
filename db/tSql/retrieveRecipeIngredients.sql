/*
Name: retrieveRecipeIngredients
Useage: CALL retrieveRecipeIngredients(1)

*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveRecipeIngredients;

DELIMITER //

CREATE PROCEDURE retrieveRecipeIngredients (
	recipeId INT
)
BEGIN
	SELECT
		ri.quantity,
		u.unitName,
		u.unitId,
		u.unitAbbreviation,
		i.ingredientId,
		i.ingredientName,
		i.ingredientDescription
	FROM
		recipe.recipe AS r
		LEFT OUTER JOIN
		recipe_ingredient AS ri
			ON r.recipeId = ri.recipeId
		LEFT OUTER JOIN
		ingredient AS i
			ON ri.ingredientId = i.ingredientId
		LEFT OUTER JOIN
		unit AS u
			ON ri.unitId = u.unitId
	WHERE
		r.recipeId = recipeId;
END //
	
DELIMITER ;