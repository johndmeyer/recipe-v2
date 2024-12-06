/*
Name: retrieveTags
Useage: EXEC retrieveTags

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
		ROUTINE_NAME = 'retrieveTags'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveTags
END

GO

CREATE PROCEDURE retrieveTags

AS

SELECT
	tagId,
	tagName,
	tagParentId,
	isParent
FROM
	dbo.tag	
	
GO





