/*
Name: createRecipeEquipment
Useage: EXEC createRecipeEquipment
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
		ROUTINE_NAME = 'createRecipeEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipeEquipment]
END

GO

CREATE PROCEDURE createRecipeEquipment(
	@recipeId INT,	
	@equipmentId INT
)
AS

INSERT INTO recipe_equipment (
	recipeId,	
	equipmentId
)
SELECT
	@recipeId,	
	@equipmentId

GO





