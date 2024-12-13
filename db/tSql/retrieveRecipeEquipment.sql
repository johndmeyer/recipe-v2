/*
Name: retrieveRecipeEquipments
Useage: EXEC retrieveRecipeEquipments @recipeId = 1

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
		ROUTINE_NAME = 'retrieveRecipeEquipments'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveRecipeEquipments
END

GO

CREATE PROCEDURE retrieveRecipeEquipments (
	@recipeId INT
)
AS 
	
SELECT	
	e.equipmentDescription,
	e.equipmentId,
	e.equipmentName
FROM
	recipe_equipment AS re
	LEFT OUTER JOIN
	equipment AS e
		ON re.equipmentId = e.equipmentId
WHERE
	re.recipeId = @recipeId
	
GO





