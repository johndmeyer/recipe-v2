/*
Name: deleteEquipment
Useage: CALL deleteEquipment(11)
*/

USE recipe;

DROP PROCEDURE IF EXISTS deleteEquipment;

DELIMITER //

CREATE PROCEDURE deleteEquipment(
	equipmentId INT
)
BEGIN
	DELETE FROM
		equipment e
	WHERE
		e.equipmentId = equipmentId;
END //

DELIMITER ;
