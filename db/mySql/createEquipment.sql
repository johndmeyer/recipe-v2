/*
Name: createEquipment
Useage: CALL createEquipment('Test Description','Test Name', 0)
*/

USE recipe;

DROP PROCEDURE IF EXISTS createEquipment;

DELIMITER //

CREATE PROCEDURE createEquipment (
	equipmentDescription VARCHAR(255),
	equipmentName VARCHAR(255),	
	equipmentParentId INT
)
BEGIN
	IF equipmentParentId = 0 THEN 
		SET equipmentParentId = null; 
    END IF;

	INSERT INTO equipment (
		equipmentName,
		equipmentDescription,
		equipmentParentId
	)
	VALUES (
		equipmentName,
		equipmentDescription,
		equipmentParentId
	);

	SELECT
		e.equipmentId,
		e.equipmentParentId,
		e.equipmentName,
		e.equipmentDescription	
	FROM
		equipment e
	WHERE
		e.equipmentName = equipmentName
		AND
		e.equipmentDescription = equipmentDescription;
END //
	
DELIMITER ;





