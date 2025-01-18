/*
Name: deleteIngredient
Useage: CALL deleteIngredient(24)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteIngredient;

DELIMITER //

CREATE PROCEDURE deleteIngredient(
	ingredientId INT
)
BEGIN
	DELETE FROM
		ingredient i
	WHERE
		i.ingredientId = ingredientId;
END //

DELIMITER ;
