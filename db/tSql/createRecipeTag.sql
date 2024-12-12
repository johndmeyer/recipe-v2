/*
Name: createRecipeTag
Useage: EXEC createRecipeTag
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
		ROUTINE_NAME = 'createRecipeTag'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipeTag]
END

GO

CREATE PROCEDURE createRecipeTag(
	@recipeId INT,	
	@tagId INT
)
AS

INSERT INTO recipe_tag (
	recipeId,	
	tagId
)
SELECT
	@recipeId,	
	@tagId

GO





