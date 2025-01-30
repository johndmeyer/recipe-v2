/*
Name: createTag
Useage: CALL createTag('Savory', 7)
*/

USE recipe;

DROP PROCEDURE IF EXISTS createTag;

DELIMITER //

CREATE PROCEDURE createTag (
	tagName VARCHAR(255),	
	tagParentId INT
)
BEGIN
	IF tagParentId = 0 THEN 
		SET tagParentId = null; 
    END IF;

	INSERT INTO tag (
		tagName,
		tagParentId
	)
	VALUES (
		tagName,
		tagParentId
	);

	SELECT
		t.tagId,
		t.tagParentId,
		t.tagName	
	FROM
		tag t
	WHERE
		t.tagName = tagName;
END //
	
DELIMITER ;





