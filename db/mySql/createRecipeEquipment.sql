/*
Name: createRecipeEquipment
Useage: CALL createRecipeEquipment(6,2,1,5)
*/

USE recipe;

DROP PROCEDURE IF EXISTS createRecipeEquipment;

DELIMITER //

CREATE PROCEDURE createRecipeEquipment(
	recipeId INT,
    equipmentId INT
)
BEGIN
	INSERT INTO recipe_equipment (
		recipeId,	
		equipmentId
	)
	VALUES (
		recipeId,	
		equipmentId
	);
END //
	
DELIMITER ;





