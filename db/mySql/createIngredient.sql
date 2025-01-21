/*
Name: createIngredient
Useage: CALL createIngredient('Test Description','Test Name', 0)
*/

USE recipe;

DROP PROCEDURE IF EXISTS createIngredient;

DELIMITER //

CREATE PROCEDURE createIngredient (
	ingredientDescription VARCHAR(255),
	ingredientName VARCHAR(255),	
	ingredientParentId INT
)
BEGIN
	IF ingredientParentId = 0 THEN 
		SET ingredientParentId = null; 
    END IF;

	INSERT INTO ingredient (
		ingredientName,
		ingredientDescription,
		ingredientParentId
	)
	VALUES (
		ingredientName,
		ingredientDescription,
		ingredientParentId
	);

	SELECT
		i.ingredientId,
		i.ingredientParentId,
		i.ingredientName,
		i.ingredientDescription	
	FROM
		ingredient i
	WHERE
		i.ingredientName = ingredientName
		AND
		i.ingredientDescription = ingredientDescription;
END //
	
DELIMITER ;





