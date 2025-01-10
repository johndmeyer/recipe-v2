/*
Name: retrieveRecipeEquipments
Useage: CALL retrieveRecipeEquipments(1)
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveRecipeEquipments;

DELIMITER //

CREATE PROCEDURE retrieveRecipeEquipments (
	recipeId INT
)
BEGIN	
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
		re.recipeId = recipeId;
END //
	
DELIMITER ;