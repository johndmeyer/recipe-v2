/*
Name: deleteRecipeEquipments
Useage: EXEC deleteRecipeEquipments @recipeId = 1
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
		ROUTINE_NAME = 'deleteRecipeEquipments'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipeEquipments
END

GO

CREATE PROCEDURE deleteRecipeEquipments(
	@recipeId INT
)
AS

DELETE FROM
	dbo.recipe_equipment
WHERE
	recipeId = @recipeId

GO





