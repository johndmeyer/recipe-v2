/*
Name: updateIngredient
Useage: CALL updateIngredient('an enclosed compartment for cooking and heating food.',25,'Oven')
*/

USE recipe;

DROP PROCEDURE IF EXISTS updateIngredient;

DELIMITER //

CREATE PROCEDURE updateIngredient (
	ingredientDescription VARCHAR(255),
    ingredientId INT,
	ingredientName VARCHAR(255)
)
BEGIN
	UPDATE 
		ingredient i
	SET
		i.ingredientName = ingredientName,
		i.ingredientDescription = ingredientDescription
	WHERE
		i.ingredientId = ingredientId;
	
	SELECT
		i.ingredientDescription,
		i.ingredientId,
        i.ingredientName,
        i.ingredientParentId
	FROM
		ingredient i
	WHERE
		i.ingredientId = ingredientId;
END //
	
DELIMITER ;
