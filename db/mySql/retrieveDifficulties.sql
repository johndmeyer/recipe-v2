/*
Name: retrieveDifficulties
Useage: CALL retrieveDifficulties
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveDifficulties;

DELIMITER //

CREATE PROCEDURE retrieveDifficulties()
BEGIN	
	SELECT
		d.difficultyId,
		d.difficultyName
	FROM
		difficulty AS d;
END //
	
DELIMITER ;
