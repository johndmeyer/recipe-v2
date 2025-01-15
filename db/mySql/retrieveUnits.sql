/*
Name: retrieveUnits
Useage: CALL retrieveUnits
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveUnits;

DELIMITER //

CREATE PROCEDURE retrieveUnits()
BEGIN	
	SELECT
		u.unitId,
		u.unitName,
        u.unitTypeId,
        u.unitAbbreviation,
        ut.unitTypeName
        
        
	FROM
		unit AS u
		LEFT OUTER JOIN
		unitType AS ut
				ON u.unitTypeId = ut.unitTypeId;
END //
	
DELIMITER ;
