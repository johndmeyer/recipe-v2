/*
Name: retrieveIngredients
Useage: CALL retrieveIngredients
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveIngredients;

DELIMITER //

CREATE PROCEDURE retrieveIngredients()
BEGIN	
	SELECT
		i.ingredientId,
		i.ingredientName,
        i.ingredientParentId,
        i.ingredientDescription,
        i.ingredientPhotoUrl
        
	FROM
		ingredient AS i;
END //
	
DELIMITER ;
