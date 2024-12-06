/*
Name: retrieveDifficulties
Useage: EXEC retrieveDifficulties

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
		ROUTINE_NAME = 'retrieveDifficulties'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveDifficulties
END

GO

CREATE PROCEDURE retrieveDifficulties
AS 

SELECT
	d.difficultyId,
	d.difficultyName
FROM
	difficulty AS d
	
GO





