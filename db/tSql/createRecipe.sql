/*
Name: createRecipe
Useage: EXEC createRecipe
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
		ROUTINE_NAME = 'createRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipe]
END

GO

CREATE PROCEDURE createRecipe(
	@difficultyId INT,	
	@recipeCookTime INT,
	@recipeDescription VARCHAR(255),
	@recipeDirections VARCHAR(255),
	@recipeName VARCHAR(255),
	@recipePhotoUrl VARCHAR(255),
	@recipeYield INT
)
AS

INSERT INTO recipe (
	difficultyId,	
	recipeCookTime,
	recipeDescription,
	recipeDirections,
	recipeName,
	recipePhotoUrl,
	recipeYield
)
SELECT
	@difficultyId,	
	@recipeCookTime,
	@recipeDescription,
	@recipeDirections,
	@recipeName,
	@recipePhotoUrl,
	@recipeYield

SELECT
	r.recipeId
FROM
	recipe r
WHERE
	r.recipeName = @recipeName
	AND
	r.recipeDescription = @recipeDescription
GO





