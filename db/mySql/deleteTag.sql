/*
Name: deleteTag
Useage: CALL deleteTag(11)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteTag;

DELIMITER //

CREATE PROCEDURE deleteTag(
	tagId INT
)
BEGIN
	DELETE FROM
		tag t
	WHERE
		t.tagId = tagId;
END //

DELIMITER ;
