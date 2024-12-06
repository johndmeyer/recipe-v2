/*
Name: retrieveEquipmentTypes
Useage: EXEC retrieveEquipmentTypes

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
		ROUTINE_NAME = 'retrieveEquipmentTypes'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveEquipmentTypes
END

GO

CREATE PROCEDURE retrieveEquipmentTypes
AS 

SELECT
	et.equipmentTypeId,
	et.equipmentTypeName
FROM
	equipmentType AS et
	
GO





