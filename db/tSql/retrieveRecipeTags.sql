/*
Name: retrieveRecipeTags
Useage: EXEC retrieveRecipeTags @recipeId = 1

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
		ROUTINE_NAME = 'retrieveRecipeTags'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveRecipeTags]
END

GO

CREATE PROCEDURE retrieveRecipeTags (
	@recipeId INT
)
AS 
	
SELECT
	t.tagId,
	t.tagName
FROM
	recipe_tag AS rt
	LEFT OUTER JOIN
	tag AS t
		ON rt.tagId = t.tagId
WHERE
	rt.recipeId = @recipeId
	
GO





