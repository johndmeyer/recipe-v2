/*
Name: deleteRecipeTags
Useage: CALL deleteRecipeTags(5)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteRecipeTags;

DELIMITER //

CREATE PROCEDURE deleteRecipeTags(
	recipeId INT
)
BEGIN
	DELETE FROM
		recipe_tag rt
	WHERE
		rt.recipeId = recipeId;
END //

DELIMITER ;





