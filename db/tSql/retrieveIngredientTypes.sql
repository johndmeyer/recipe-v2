/*
Name: retrieveIngredientTypes
Useage: EXEC retrieveIngredientTypes

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
		ROUTINE_NAME = 'retrieveIngredientTypes'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveIngredientTypes
END

GO

CREATE PROCEDURE retrieveIngredientTypes
AS 

SELECT
	it.ingredientTypeId,
	it.ingredientTypeName
FROM
	ingredientType AS it
	
GO





