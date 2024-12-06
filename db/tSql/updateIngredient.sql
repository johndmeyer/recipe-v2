/*
Name: updateIngredient
Useage: EXEC updateIngredient @IngredientName = 'Bacon', @ingredientDescription='Probably the best meat ever', @ingredientParentId=5

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
		ROUTINE_NAME = 'updateIngredient'
)
BEGIN
	DROP PROCEDURE [dbo].updateIngredient
END

GO

CREATE PROCEDURE updateIngredient
	@ingredientName VARCHAR(255),
	@ingredientDescription VARCHAR(255),
	@ingredientId INT
AS

UPDATE 
	ingredient
SET
	ingredientName = @ingredientName,
	ingredientDescription = @ingredientDescription
WHERE
	ingredientId = @ingredientId
	
SELECT
	@ingredientId AS ingredientId
		
GO





