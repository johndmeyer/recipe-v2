/*
Name: retrieveRecipeTags
Useage: CALL retrieveRecipeTags(1)
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveRecipeTags;

DELIMITER //

CREATE PROCEDURE retrieveRecipeTags (
	recipeId INT
)
BEGIN	
	SELECT
		t.tagId,
		t.tagName
	FROM
		recipe_tag AS rt
		LEFT OUTER JOIN
		tag AS t
			ON rt.tagId = t.tagId
	WHERE
		rt.recipeId = recipeId;
END //
	
DELIMITER ;





