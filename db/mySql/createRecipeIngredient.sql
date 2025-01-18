/*
Name: createRecipeIngredient
Useage: CALL createRecipeIngredient('description',2,'directions',60,'name','photo url',6)
*/

USE recipe;

DROP PROCEDURE IF EXISTS createRecipeIngredient;

DELIMITER //

CREATE PROCEDURE createRecipeIngredient(
	recipeId INT,
    ingredientId INT,
    unitId INT,
    quantity INT
)
BEGIN
	IF unitId = 0 THEN 
		SET unitId = null; 
    END IF;
    
	INSERT INTO recipe_ingredient (
		recipeId,	
		ingredientId,
		unitId,
		quantity
	)
	VALUES (
		recipeId,	
		ingredientId,
		unitId,
		quantity
	);
END //
	
DELIMITER ;





