/*
Name: retrieveTags
Useage: CALL retrieveTags
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveTags;

DELIMITER //

CREATE PROCEDURE retrieveTags ()
BEGIN	
	SELECT
		t.tagId,
		t.tagName,
        t.tagParentId
	FROM
		tag AS t;
END //
	
DELIMITER ;





