/*
Name: retrieveIngredients
Useage: EXEC retrieveRecipe @recipeId = 1

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
		ROUTINE_NAME = 'retrieveRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveRecipe]
END

GO

CREATE PROCEDURE retrieveRecipe (
	@recipeId INT
)
AS 

--DECLARE @recipeId INT = 1;

SELECT
	d.difficultyName,
	r.recipeCookTime,
	r.recipeDescription,
	r.recipeDirections,
	r.recipeName,
	r.recipePhotoUrl,
	r.recipeYield
FROM
	recipe.dbo.recipe AS r
	LEFT OUTER JOIN
	difficulty AS d
		ON r.difficultyId = d.difficultyId
WHERE
	r.recipeId = @recipeId

EXEC retrieveRecipeIngredients @recipeId
	
EXEC retrieveRecipeEquipment @recipeId
	
GO





