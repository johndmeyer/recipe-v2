/*
Name: updateEquipment
Useage: EXEC updateEquipment @equipmentName = 'Oven', @equipmentDescription='an enclosed compartment for cooking and heating food.', @equipmentParentId=5

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
		ROUTINE_NAME = 'updateEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].updateEquipment
END

GO

CREATE PROCEDURE updateEquipment
	@equipmentName VARCHAR(255),
	@equipmentDescription VARCHAR(255),
	@equipmentId INT
AS

UPDATE 
	equipment
SET
	equipmentName = @equipmentName,
	equipmentDescription = @equipmentDescription
WHERE
	equipmentId = @equipmentId
	
SELECT
	@equipmentId AS equipmentId
		
GO





