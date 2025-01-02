USE recipe;

INSERT INTO ingredient (
	ingredientName,
	ingredientDescription
)
VALUES
(
	'Basic',
	'A type reserved for the most basic of ingredients (e.g. Water)'
),
(
	'Herbs and Spices',
	'Any seed, fruit, bark, or other substance in a form primarily used for flavoring or coloring food'
),
(
	'Meat',
	'Animal tissue, often muscle, that is eaten as food'
),
(
	'Grain',
	'A grass cultivated for it''s edible grain'
),
(
	'Fruit',
	'The fleshy or dry ripened ovary of a flowering plant, enclosing the seed or seeds'
),
(
	'Vegetable',
	'Any other part of a plant that is not fruit, such as the leaves, stems, roots, and bulbs'
);

INSERT INTO ingredient (
	ingredientName,
	ingredientParentId,
	ingredientDescription
)
SELECT	
	'Water',
	i.ingredientId,
	'Perhaps the most basic ingredient'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Basic'
	
UNION ALL

SELECT	
	'Vegetable Oil',
	i.ingredientId,
	'Oil extracted from the seeds or other parts of edible plants'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Basic'
	
UNION ALL

SELECT
	'Kosher Salt',
	i.ingredientId,
	'A coarse edible salt, usually without common additives such as iodine'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Herbs and Spices'
	
UNION ALL

SELECT
	'Black Pepper',
	i.ingredientId,
	'The dried seed of a flowering vine in the family Piperaceae'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Herbs and Spices'
	
UNION ALL

SELECT
	'Garlic',
	i.ingredientId,
	'A species of bulbous flowing plant in the genus Allium'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Herbs and Spices'
	
UNION ALL

SELECT
	'Dry Garbanzo Beans',
	i.ingredientId, 
	'Also known as the chick pea, dried garbanzo beans are round, beige in color, and are about 1 cm in circumference'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Vegetable'
	
UNION ALL

SELECT
	'Fire Roasted Green Chilies',
	i.ingredientId,
	'Available fresh, frozen or canned, green chilies (e.g. Hatch) are roasted over an open flame so the skin peels off'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Vegetable'
	
UNION ALL

SELECT
	'Long Grain Wild Rice Blend',
	i.ingredientId,
	'A mix of various types of long grain rice, including a black wild rice'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Grain'
	
UNION ALL

SELECT
	'Whole Chicken',
	i.ingredientId,
	'A raw whole chicken that has been gutted and de-feathered'
FROM
	ingredient AS i
WHERE
	i.ingredientName = 'Meat';

INSERT INTO unitType (
	unitTypeName
)
VALUES 
(
	'Metric'
),(
	'Imperial'
),(
	'Natural'
);

INSERT INTO unit (
	unitTypeId,
	unitName,
	unitAbbreviation
)
SELECT
	ut.unitTypeId,
	'Gram',
	'g'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Metric'
UNION ALL
SELECT
	ut.unitTypeId,
	'Kilogram',
	'kg'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Metric'
UNION ALL
SELECT
	ut.unitTypeId,
	'Liter',
	'l'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Metric'
UNION ALL
SELECT
	ut.unitTypeId,
	'Mililiter',
	'ml'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Metric'
UNION ALL
SELECT
	ut.unitTypeId,
	'Celsius',
	'C'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Metric'
UNION ALL
SELECT
	ut.unitTypeId,
	'Clove',
	'n/a'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Natural'
UNION ALL
SELECT
	ut.unitTypeId,
	'Head',
	'n/a'
FROM
	unitType AS ut
WHERE
	ut.unitTypeName = 'Natural';

INSERT INTO equipment (
	equipmentName,
	equipmentDescription
)
VALUES
(
	'Appliances',
	'Machines used in cooking (e.g. oven, air fryer, etc...)'
),(
	'Food Preparation',
	'Other items used in cooking (e.g. cutting board, spatula, etc...)'
),(
	'Servingware',
	'Items used to serve food once it has been prepared (e.g. plates, utensils, etc...)'
);

INSERT INTO equipment (
	equipmentParentId,
	equipmentName,
	equipmentDescription	
)
SELECT
	e.equipmentId,
	'Dutch Oven',
	'A heavy, wide, fairly shallow pot with a tight fitting lid'
FROM
	equipment AS e
WHERE
	e.equipmentName = 'Food Preparation'
UNION ALL
SELECT
	e.equipmentId,
	'Burner',
	'A heat source upon which pots, pans or other vessels can be placed'
FROM
	equipment AS e
WHERE
	e.equipmentName = 'Food Preparation'
UNION ALL
SELECT
	e.equipmentId,
	'Cutting Board',
	'A wooden or plastic board used to protect the countertop and/or assist in cleaning in food preparation'
FROM
	equipment AS e
WHERE
	e.equipmentName = 'Food Preparation'
UNION ALL
SELECT
	e.equipmentId,
	'Chefs Knife',
	'A large general utility knife used in food preparation'
FROM
	equipment AS e
WHERE
	e.equipmentName = 'Food Preparation'
UNION ALL
SELECT
	e.equipmentId,
	'Insta Pot',
	'A pressure cooker with a built in burner and timer'
FROM
	equipment AS e
WHERE
	e.equipmentName = 'Food Preparation'
UNION ALL
SELECT
	e.equipmentId,
	'Bowl',
	'A semi spherical dish used for serving food'
FROM
	equipment AS e
WHERE
	e.equipmentName = 'Servingware';

INSERT INTO difficulty (
	difficultyName
)
VALUES
( 
	'Easy'
),(
	'Medium'
),(
	'Difficult'
);

INSERT INTO recipe (
	difficultyId,
	recipeName,
	recipeCookTime,
	recipeYield,
	recipeDescription,
	recipeDirections,
	recipePhotoUrl
)
VALUES
(
	2,
	'Bowl of the Wife of Kit Carson',
	60,
	6,
	'A slightly spicy soup made with chicken, rice, and garbanzo beans',
	'yada yada',
	'https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg'
);

INSERT INTO recipe_ingredient (
	recipeId,
	ingredientId,
	quantity,
	unitId
)
SELECT
	r.recipeId,
	i.ingredientId,
	1,
	NULL
FROM
	recipe AS r
	CROSS JOIN
	ingredient AS i
WHERE
	r.recipeName = 'Bowl of the wife of Kit Carson'
	AND
	i.ingredientName = 'Whole Chicken'
UNION ALL
SELECT
	r.recipeId,
	i.ingredientId,
	250,
	u.unitId
FROM
	recipe AS r
	CROSS JOIN
	ingredient AS i
	CROSS JOIN
	unit AS u
WHERE
	r.recipeName = 'Bowl of the wife of Kit Carson'
	AND
	i.ingredientName = 'Dry Garbanzo Beans'
	AND
	u.unitAbbreviation = 'ml';

INSERT INTO recipe_equipment (
	recipeId,
	equipmentId
)
SELECT
	r.recipeId,
	i.equipmentId
FROM
	recipe AS r
	CROSS JOIN
	equipment AS i
WHERE
	r.recipeName = 'Bowl of the wife of Kit Carson'
	AND
	i.equipmentName = 'Burner'
UNION ALL
SELECT
	r.recipeId,
	i.equipmentId
FROM
	recipe AS r
	CROSS JOIN
	equipment AS i
WHERE
	r.recipeName = 'Bowl of the wife of Kit Carson'
	AND
	i.equipmentName = 'Dutch Oven';
	
INSERT INTO tag (
	tagName,
	isParent
)
VALUES
(
	'Cusine Type',
	1
);

INSERT INTO tag (
	tagName,
	tagParentId
)
VALUES
(
	'American South West',
	1
),(
	'Asian',
	1
),(
	'Cajun',
	1
),(
	'BBQ',
	1
),(
	'Mexican',
	1
),(
	'Indian',
	1
);