/*
Name: retrieveIngredients
Useage: EXEC retrieveIngredients

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
		ROUTINE_NAME = 'retrieveIngredients'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveIngredients
END

GO

CREATE PROCEDURE retrieveIngredients

AS

SELECT
	i.ingredientId,
	i.ingredientParentId,
	i.ingredientName,
	i.ingredientDescription,
	i.ingredientPhotoUrl
FROM
	ingredient AS i
	
GO





