/*
Name: deleteRecipe
Useage: EXEC deleteRecipe @recipeId = 1
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
		ROUTINE_NAME = 'deleteRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipe
END

GO

CREATE PROCEDURE deleteRecipe(
	@recipeId INT
)
AS

EXEC deleteRecipeEquipments @recipeId

EXEC deleteRecipeIngredients @recipeId

EXEC deleteRecipeTags @recipeId
	
DELETE FROM
	dbo.recipe
WHERE
	recipeId = @recipeId

GO
