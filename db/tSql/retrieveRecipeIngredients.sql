/*
Name: retrieveRecipeIngredients
Useage: EXEC retrieveRecipeIngredients @recipeId = 1

*/

USE recipe
GO

IF EXISTS (
	SELECT 
		* 
	FROM 
		INFORMATION_SCHEMA.ROUTINES
	WHERE
		ROUTINE_TYPE = 'PROCEDURE' 
		AND
		ROUTINE_SCHEMA = 'dbo'
		AND
		ROUTINE_NAME = 'retrieveRecipeIngredients'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveRecipeIngredients
END

GO

CREATE PROCEDURE retrieveRecipeIngredients (
	@recipeId INT
)
AS 

SELECT
	ri.quantity,
	u.unitName,
	i.ingredientName,
	i.ingredientDescription,
	it.ingredientTypeName	
FROM
	recipe.dbo.recipe AS r
	LEFT OUTER JOIN
	recipe_ingredient AS ri
		ON r.recipeId = ri.recipeId
	LEFT OUTER JOIN
	ingredient AS i
		ON ri.ingredientId = i.ingredientId
	LEFT OUTER JOIN
	ingredientType AS it
		on i.ingredientTypeId = it.ingredientTypeId
	LEFT OUTER JOIN
	unit AS u
		ON ri.unitId = u.unitId
WHERE
	r.recipeId = @recipeId
	
GO





