/*
Name: retrieveUnitTypes
Useage: CALL retrieveUnitTypes
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveUnitTypes;

DELIMITER //

CREATE PROCEDURE retrieveUnitTypes()
BEGIN	
	SELECT
		i.unitTypeId,
		i.unitTypeName
        
	FROM
		unitType AS i;
END //
	
DELIMITER ;
