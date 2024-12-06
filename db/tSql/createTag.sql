/*
Name: createTag
Useage: EXEC createTag @tagName='Savory', @tagParentId=8

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
		ROUTINE_NAME = 'createTag'
)
BEGIN
	DROP PROCEDURE [dbo].createTag
END

GO

CREATE PROCEDURE createTag
	@tagName VARCHAR(255),
	@tagParentId INT = NULL
AS

INSERT INTO tag (
	tagName,
	isParent,
	tagParentId
)
SELECT
	@tagName,
	CASE
		WHEN @tagParentId = NULL THEN 1
		ELSE 0
	END,
	@tagParentId

SELECT
	t.tagId
FROM
	tag t
WHERE
	t.tagName = @tagName
	AND
	t.tagParentId = @tagParentId
	
GO





