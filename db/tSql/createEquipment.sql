/*
Name: createEquipment
Useage: EXEC createEquipment @equipmentName='Bowl', @equipmentDescription='A round, deep dish or basin used for food or liquid.', @equipmentParentId=43

*/

USE recipe
GO

IF EXISTS (
	SELECT 
		* 
	FROM 
		INFORMATION_SCHEMA.ROUTINES
	WHERE
		ROUTINE_TYPE = 'PROCEDURE' 
		AND
		ROUTINE_SCHEMA = 'dbo'
		AND
		ROUTINE_NAME = 'createEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].createEquipment
END

GO

CREATE PROCEDURE createEquipment
	@equipmentName VARCHAR(255),
	@equipmentDescription VARCHAR(255),
	@equipmentParentId INT = NULL
AS

INSERT INTO equipment (
	equipmentName,
	equipmentDescription,
	equipmentParentId
)
SELECT
	@equipmentName,
	@equipmentDescription,
	@equipmentParentId

SELECT
	e.equipmentId
FROM
	equipment e
WHERE
	e.equipmentName = @equipmentName
	AND
	e.equipmentDescription = @equipmentDescription
	
GO





