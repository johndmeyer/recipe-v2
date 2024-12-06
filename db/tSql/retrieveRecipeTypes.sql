/*
Name: retrieveRecipeTypes
Useage: EXEC retrieveRecipeTypes

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
		ROUTINE_NAME = 'retrieveRecipeTypes'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveRecipeTypes]
END

GO

CREATE PROCEDURE retrieveRecipeTypes
AS 

SELECT
	rt.recipeTypeId,
	rt.recipeTypeName
FROM
	recipeType AS rt
	
GO





