/*
Name: retrieveRecipes
Useage: EXEC retrieveRecipes @recipeTypeId = 1

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

CREATE PROCEDURE retrieveRecipes --(
	--@recipeTypeId INT = NULL,
	--@recipeCusineTypeId INT = NULL,
	--@recipeMaxCookTime INT = NULL
--)
AS 

--DECLARE @recipeTypeId INT = 1;

DECLARE @query NVARCHAR(512)
--DECLARE @whereRecipeTypeId NVARCHAR(255)
--DECLARE @whereRecipeCusineTypeId NVARCHAR(255)
--DECLARE @whereRecipeMaxCookTime NVARCHAR(255)

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
			ON r.difficultyId = d.difficultyId'
			
-- TODO: Finish the logic for the dynamic where clauses: tags, difficulty, cook time


EXEC SP_EXECUTESQL @query

	
GO





