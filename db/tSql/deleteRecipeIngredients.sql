/*
Name: deleteRecipeIngredients
Useage: EXEC deleteRecipeIngredients @recipeId = 1
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
		ROUTINE_NAME = 'deleteRecipeIngredients'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipeIngredients
END

GO

CREATE PROCEDURE deleteRecipeIngredients(
	@recipeId INT
)
AS

DELETE FROM
	dbo.recipe_ingredient
WHERE
	recipeId = @recipeId

GO





