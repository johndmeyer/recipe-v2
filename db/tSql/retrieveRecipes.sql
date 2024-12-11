/*
Name: retrieveRecipes
Useage: EXEC retrieveRecipes @recipeTagId = 9, @recipeDifficultyId = 2, @recipeCookTime = 60

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
		ROUTINE_NAME = 'retrieveRecipes'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveRecipes]
END

GO

CREATE PROCEDURE retrieveRecipes(
	@recipeTagId INT = NULL,
	@recipeDifficultyId INT = NULL,
	@recipeCookTime INT = NULL
)
AS 

DECLARE @query NVARCHAR(512)

SET @query = '
	SELECT
		r.recipeId,
		r.recipeName,
		r.recipeDescription,
		r.recipePhotoUrl,
		r.recipeCookTime,
		r.recipeYield,
		d.difficultyName
	FROM
		recipe.dbo.recipe AS r
		LEFT OUTER JOIN
		recipe.dbo.difficulty AS d
			ON r.difficultyId = d.difficultyId
		LEFT OUTER JOIN
		recipe.dbo.recipe_tag rt
			ON r.recipeId = rt.recipeId'
			
IF @recipeTagId <> '' OR @recipeDifficultyId <> '' OR @recipeCookTime <> ''
	SET @query = @query + '
	WHERE'
	
IF @recipeTagId <> ''
	SET @query = @query + '
		rt.tagId = ' + CAST(@recipeTagId AS VARCHAR(8))
		
IF @recipeTagId <> '' AND @recipeDifficultyId <> ''
	SET @query = @query + '
		AND'
		
IF @recipeDifficultyId <> ''
	SET @query = @query + '
		d.difficultyId >= ' + CAST(@recipeDifficultyId AS VARCHAR(1))
		
IF (@recipeTagId <> '' OR @recipeDifficultyId <> '') AND @recipeCookTime <> ''
	SET @query = @query + '
		AND'
		
IF @recipeCookTime <> ''
	SET @query = @query + '
		r.recipeCookTime >= ' + CAST(@recipeCookTime AS VARCHAR(3))
 
EXEC SP_EXECUTESQL @query 

	
GO





