/*
Name: updateEquipment
Useage: CALL updateEquipment('an enclosed compartment for cooking and heating food.',24,'Oven')
*/

USE recipe;

DROP PROCEDURE IF EXISTS updateEquipment;

DELIMITER //

CREATE PROCEDURE updateEquipment (
	equipmentDescription VARCHAR(255),
    equipmentId INT,
	equipmentName VARCHAR(255)
)
BEGIN
	UPDATE 
		equipment e
	SET
		e.equipmentName = equipmentName,
		e.equipmentDescription = equipmentDescription
	WHERE
		e.equipmentId = equipmentId;
	
	SELECT
		e.equipmentDescription,
		e.equipmentId,
        e.equipmentName,
        e.equipmentParentId
	FROM
		equipment e
	WHERE
		e.equipmentId = equipmentId;
END //
	
DELIMITER ;
