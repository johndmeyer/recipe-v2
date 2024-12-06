/*
Name: retrieveRecipeEquipment
Useage: EXEC retrieveRecipeEquipment @recipeId = 1

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
		ROUTINE_NAME = 'retrieveRecipeEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveRecipeEquipment
END

GO

CREATE PROCEDURE retrieveRecipeEquipment (
	@recipeId INT
)
AS 
	
SELECT
	e.equipmentName,
	e.equipmentDescription,
	et.equipmentTypeName	
FROM
	recipe.dbo.recipe AS r
	LEFT OUTER JOIN
	recipe_equipment AS re
		ON r.recipeId = re.recipeId
	LEFT OUTER JOIN
	equipment AS e
		ON re.equipmentId = e.equipmentId
	LEFT OUTER JOIN
	equipmentType AS et
		on e.equipmentTypeId = et.equipmentTypeId
WHERE
	r.recipeId = @recipeId
	
GO





