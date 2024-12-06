/*
Name: retrieveEquipments
Useage: EXEC retrieveEquipments

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
		ROUTINE_NAME = 'retrieveEquipments'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveEquipments
END

GO

CREATE PROCEDURE retrieveEquipments

AS

SELECT
	e.equipmentId,
	e.equipmentParentId,
	e.equipmentName,
	e.equipmentDescription,
	e.equipmentPhotoUrl
FROM
	equipment AS e
	
GO





