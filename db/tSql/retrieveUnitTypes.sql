/*
Name: retrieveUnitTypes
Useage: EXEC retrieveUnitTypes

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
		ROUTINE_NAME = 'retrieveUnitTypes'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveUnitTypes]
END

GO

CREATE PROCEDURE retrieveUnitTypes
AS 

SELECT
	ut.unitTypeId,
	ut.unitTypeName
FROM
	unitType AS ut
	
GO





