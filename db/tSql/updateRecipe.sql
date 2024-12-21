/*
Name: updateRecipe
Useage: EXEC updateRecipe @recipeId = 2, @

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
		ROUTINE_NAME = 'updateRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].updateRecipe
END

GO

CREATE PROCEDURE updateRecipe	
	@difficultyId INT,	
	@recipeCookTime INT,
	@recipeDescription VARCHAR(255),
	@recipeDirections VARCHAR(255),
	@recipeId INT,
	@recipeName VARCHAR(255),
	@recipePhotoUrl VARCHAR(255),
	@recipeYield INT
AS

UPDATE 
	recipe
SET
	difficultyId = @difficultyId,	
	recipeCookTime = @recipeCookTime,
	recipeDescription = @recipeDescription,
	recipeDirections = @recipeDirections,
	recipeName = @recipeName,
	recipePhotoUrl = @recipePhotoUrl,
	recipeYield = @recipeYield
WHERE
	recipeId = @recipeId
		
GO





