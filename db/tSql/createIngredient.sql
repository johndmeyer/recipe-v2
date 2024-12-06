/*
Name: createIngredient
Useage: EXEC createIngredient @ingredientName='Rice', @ingredientDescription='An edible starchy cereal grain and the grass plant (family Poaceae) by which it is produced', @ingredientParentId=43

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
		ROUTINE_NAME = 'createIngredient'
)
BEGIN
	DROP PROCEDURE [dbo].createIngredient
END

GO

CREATE PROCEDURE createIngredient
	@ingredientName VARCHAR(255),
	@ingredientDescription VARCHAR(255),
	@ingredientParentId INT = NULL
AS

INSERT INTO ingredient (
	ingredientName,
	ingredientDescription,
	ingredientParentId
)
SELECT
	@ingredientName,
	@ingredientDescription,
	@ingredientParentId

SELECT
	i.ingredientId
FROM
	ingredient i
WHERE
	i.ingredientName = @ingredientName
	AND
	i.ingredientParentId = @ingredientParentId
	
GO





