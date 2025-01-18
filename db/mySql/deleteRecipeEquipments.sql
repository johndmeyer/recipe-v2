/*
Name: deleteRecipeEquipments
Useage: CALL deleteRecipeEquipments(5)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteRecipeEquipments;

DELIMITER //

CREATE PROCEDURE deleteRecipeEquipments(
	recipeId INT
)
BEGIN
	DELETE FROM
		recipe_equipment re
	WHERE
		re.recipeId = recipeId;
END //

DELIMITER ;





