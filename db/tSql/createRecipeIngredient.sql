/*
Name: createRecipeIngredient
Useage: EXEC createRecipeIngredient
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
		ROUTINE_NAME = 'createRecipeIngredient'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipeIngredient]
END

GO

CREATE PROCEDURE createRecipeIngredient(
	@recipeId INT,	
	@ingredientId INT,
	@unitId INT,
	@quantity INT
)
AS

INSERT INTO recipe_ingredient (
	recipeId,	
	ingredientId,
	unitId,
	quantity
)
SELECT
	@recipeId,	
	@ingredientId INT,
	@unitId INT,
	@quantity INT

GO





