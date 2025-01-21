/*
Name: retrieveEquipments
Useage: CALL retrieveEquipments
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveEquipments;

DELIMITER //

CREATE PROCEDURE retrieveEquipments()
BEGIN	
	SELECT
		e.equipmentId,
		e.equipmentName,
        e.equipmentParentId,
        e.equipmentDescription,
        e.equipmentPhotoUrl
	FROM
		equipment AS e;
END //
	
DELIMITER ;
