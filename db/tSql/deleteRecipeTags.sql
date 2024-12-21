/*
Name: deleteRecipeTags
Useage: EXEC deleteRecipeTags @recipeId = 1
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
		ROUTINE_NAME = 'deleteRecipeTags'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipeTags
END

GO

CREATE PROCEDURE deleteRecipeTags(
	@recipeId INT
)
AS

DELETE FROM
	dbo.recipe_tag
WHERE
	recipeId = @recipeId

GO





