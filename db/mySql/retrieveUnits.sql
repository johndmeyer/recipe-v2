/*
Name: retrieveUnits
Useage: CALL retrieveUnits(1)
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveUnits;

DELIMITER //

CREATE PROCEDURE retrieveUnits(
	unitTypeId INT
)
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
			ON u.unitTypeId = ut.unitTypeId
	WHERE
		u.unitTypeId = unitTypeId
        OR
        u.unitTypeId = 3;
END //
	
DELIMITER ;
