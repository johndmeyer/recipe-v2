/*
Name: retrieveUnits
Useage: EXEC retrieveUnits

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
		ROUTINE_NAME = 'retrieveUnits'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveUnits
END

GO

CREATE PROCEDURE retrieveUnits
	@unitTypeName VARCHAR(255) = 'Metric'
AS 

SELECT
	u.unitId,
	u.unitName,
	u.unitAbbreviation
FROM
	unit AS u
	
GO





