/*
Name: updateTag
Useage: CALL updateTag(11,'Name')
*/

USE recipe;

DROP PROCEDURE IF EXISTS updateTag;

DELIMITER //

CREATE PROCEDURE updateTag (
    tagId INT,
	tagName VARCHAR(255)
)
BEGIN
	UPDATE 
		tag t
	SET
		t.tagName = tagName
	WHERE
		t.tagId = tagId;
	
	SELECT
		t.tagId,
        t.tagName,
        t.tagParentId
	FROM
		tag t
	WHERE
		t.tagId = tagId;
END //
	
DELIMITER ;
