/*
Name: updateTag
Useage: EXEC updateTag @tagName = 'Flavor Profile' @tagParentId

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
		ROUTINE_NAME = 'updateTag'
)
BEGIN
	DROP PROCEDURE [dbo].updateTag
END

GO

CREATE PROCEDURE updateTag
	@tagName VARCHAR(255),
	@tagId INT
AS

UPDATE 
	tag
SET
	tagName = @tagName
WHERE
	tagId = @tagId
	
SELECT
	@tagId AS tagId
		
GO





