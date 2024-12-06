USE recipe

GO

DECLARE @recipeId INT = 1;

SELECT
	r.recipeName,
	r.recipeDescription,
	rt.recipeTypeName
FROM
	recipe.dbo.recipe AS r
	LEFT OUTER JOIN
	recipeType AS rt
		ON r.recipeTypeId = rt.recipeTypeId
WHERE
	r.recipeId = @recipeId

SELECT
	ri.quantity,
	u.unitName,
	i.ingredientName,
	i.ingredientDescription,
	it.ingredientTypeName	
FROM
	recipe.dbo.recipe AS r
	LEFT OUTER JOIN
	recipe_ingredient AS ri
		ON r.recipeId = ri.recipeId
	LEFT OUTER JOIN
	ingredient AS i
		ON ri.ingredientId = i.ingredientId
	LEFT OUTER JOIN
	ingredientType AS it
		on i.ingredientTypeId = it.ingredientTypeId
	LEFT OUTER JOIN
	unit AS u
		ON ri.unitId = u.unitId
WHERE
	r.recipeId = @recipeId
	
SELECT
	e.equipmentName,
	e.equipmentDescription,
	et.equipmentTypeName	
FROM
	recipe.dbo.recipe AS r
	LEFT OUTER JOIN
	recipe_equipment AS re
		ON r.recipeId = re.recipeId
	LEFT OUTER JOIN
	equipment AS e
		ON re.equipmentId = e.equipmentId
	LEFT OUTER JOIN
	equipmentType AS et
		on e.equipmentTypeId = et.equipmentTypeId
WHERE
	r.recipeId = @recipeId