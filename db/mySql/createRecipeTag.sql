/*
Name: createRecipeTag
Useage: CALL createRecipeTag(6,2)
*/

USE recipe;

DROP PROCEDURE IF EXISTS createRecipeTag;

DELIMITER //

CREATE PROCEDURE createRecipeTag(
	recipeId INT,
    tagId INT
)
BEGIN
	INSERT INTO recipe_tag (
		recipeId,	
		tagId
	)
	VALUES (
		recipeId,	
		tagId
	);
END //
	
DELIMITER ;





