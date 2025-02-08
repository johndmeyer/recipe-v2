/*
**
** Recipe Database Creation
**
*/

/*
** CREATE DATABASE recipe_db -- This stepe likely won't be neccessary when creating the database in Azure or other cloud providers
** GO
*/

USE recipe_db

GO

/* ----------------------------------------------
** ----------------------------------------------
** ----------------------------------------------
** Recipe Database Table Creation
** ----------------------------------------------
** ----------------------------------------------
** ---------------------------------------------- */

CREATE TABLE difficulty (
	difficultyId INT IDENTITY(1,1) PRIMARY KEY,
	difficultyName VARCHAR(32) NOT NULL
)

GO

CREATE TABLE equipment (
	equipmentId INT IDENTITY(1,1) PRIMARY KEY,
	equipmentIdParent INT REFERENCES equipment(equipmentId),
	equipmentName VARCHAR(255) NOT NULL, 	
	equipmentDescription VARCHAR (255) NOT NULL,
	equipmentPhotoUrl VARCHAR(255)
)

GO

CREATE TABLE ingredient (
	ingredientId INT IDENTITY(1,1) PRIMARY KEY,	
	ingredientIdParent INT REFERENCES ingredient(ingredientId),
	ingredientName VARCHAR(255) NOT NULL,	
	ingredientDescription VARCHAR(255) NOT NULL,
	ingredientPhotoUrl VARCHAR(255)
)

GO

CREATE TABLE recipe (
	recipeId INT IDENTITY(1,1) PRIMARY KEY,
	difficultyId INT NOT NULL FOREIGN KEY REFERENCES difficulty(difficultyId),
	recipeName VARCHAR(255) NOT NULL,
	recipeDuration INT NOT NULL,
	recipeYield INT NOT NULL,
	recipeDescription VARCHAR(255) NOT NULL,
	recipeDirections VARCHAR(255) NOT NULL,
	recipePhotoUrl VARCHAR(255)
)

GO

CREATE TABLE tag (
	tagId INT IDENTITY(1,1) PRIMARY KEY,
	tagIdParent INT REFERENCES tag(tagId),
	tagName VARCHAR(255) NOT NULL,
	
)

GO

CREATE TABLE unitType (--e.g. imperial, metric, primatave
	unitTypeId INT IDENTITY(1,1) PRIMARY KEY, 
	unitTypeName VARCHAR(255) NOT NULL
)

GO

CREATE TABLE unit (
	unitId INT IDENTITY(1,1) PRIMARY KEY,
	unitTypeId INT NOT NULL FOREIGN KEY REFERENCES unitType(unitTypeId),
	unitName VARCHAR(255) NOT NULL,
	unitAbbreviation VARCHAR(16) NOT NULL
)

GO

CREATE TABLE recipe_ingredient (
	recipeId INT NOT NULL FOREIGN KEY REFERENCES recipe(recipeId),
	ingredientId INT NOT NULL FOREIGN KEY REFERENCES ingredient(ingredientId),
	quantity INT NOT NULL,
	unitId INT FOREIGN KEY REFERENCES unit(unitId)
)

GO

CREATE TABLE recipe_equipment (
	recipeId INT NOT NULL FOREIGN KEY REFERENCES recipe(recipeId),
	equipmentId INT NOT NULL FOREIGN KEY REFERENCES equipment(equipmentId), 
)

GO

CREATE TABLE recipe_tag (
	recipeId INT NOT NULL FOREIGN KEY REFERENCES recipe(recipeId),
	tagId INT NOT NULL FOREIGN KEY REFERENCES tag(tagId)
)

GO

/* ----------------------------------------------
** ----------------------------------------------
** ----------------------------------------------
** Recipe Database Stored Procedure Creation
** ----------------------------------------------
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** ----------------------------------------------
** difficulty
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: retrieveDifficulties
** Useage: EXEC retrieveDifficulties
** ---------------------------------------------- */
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

/* ----------------------------------------------
** ----------------------------------------------
** equipment
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createEquipment
** Useage: EXEC createEquipment @equipmentName='Bowl', @equipmentDescription='A round, deep dish or basin used for food or liquid.', @equipmentParentId=43
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'createEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].createEquipment
END
GO
CREATE PROCEDURE createEquipment
	@equipmentName VARCHAR(255),
	@equipmentDescription VARCHAR(255),
	@equipmentIdParent INT = NULL
AS

INSERT INTO equipment (
	equipmentName,
	equipmentDescription,
	equipmentIdParent
)
SELECT
	@equipmentName,
	@equipmentDescription,
	@equipmentIdParent

SELECT
	e.equipmentId
FROM
	equipment e
WHERE
	e.equipmentName = @equipmentName
	AND
	e.equipmentDescription = @equipmentDescription
GO

/* ----------------------------------------------
** Name: retrieveEquipments
** Useage: EXEC retrieveEquipments
** ---------------------------------------------- */
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
	e.equipmentIdParent,
	e.equipmentName,
	e.equipmentDescription,
	e.equipmentPhotoUrl
FROM
	equipment AS e
GO

/* ----------------------------------------------
** Name: updateEquipment
** Useage: EXEC updateEquipment @equipmentName = 'Oven', @equipmentDescription='an enclosed compartment for cooking and heating food.', @equipmentParentId=5
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'updateEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].updateEquipment
END
GO
CREATE PROCEDURE updateEquipment
	@equipmentName VARCHAR(255),
	@equipmentDescription VARCHAR(255),
	@equipmentId INT
AS
UPDATE 
	equipment
SET
	equipmentName = @equipmentName,
	equipmentDescription = @equipmentDescription
WHERE
	equipmentId = @equipmentId
	
SELECT
	@equipmentId AS equipmentId	
GO

/* ----------------------------------------------
** ----------------------------------------------
** ingredient
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
Name: createIngredient
Useage: EXEC createIngredient @ingredientName='Rice', @ingredientDescription='An edible starchy cereal grain and the grass plant (family Poaceae) by which it is produced', @ingredientParentId=43
** ---------------------------------------------- */
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
	@ingredientIdParent INT = NULL
AS
INSERT INTO ingredient (
	ingredientName,
	ingredientDescription,
	ingredientIdParent
)
SELECT
	@ingredientName,
	@ingredientDescription,
	@ingredientIdParent
SELECT
	i.ingredientId
FROM
	ingredient i
WHERE
	i.ingredientName = @ingredientName
	AND
	i.ingredientDescription = @ingredientDescription
GO

/* ----------------------------------------------
** Name: retrieveIngredients
** Useage: EXEC retrieveIngredients
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'retrieveIngredients'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveIngredients
END
GO
CREATE PROCEDURE retrieveIngredients
AS
SELECT
	i.ingredientId,
	i.ingredientIdParent,
	i.ingredientName,
	i.ingredientDescription,
	i.ingredientPhotoUrl
FROM
	ingredient AS i	
GO

/* ----------------------------------------------
Name: updateIngredient
Useage: EXEC updateIngredient @IngredientName = 'Bacon', @ingredientDescription='Probably the best meat ever', @ingredientParentId=5
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'updateIngredient'
)
BEGIN
	DROP PROCEDURE [dbo].updateIngredient
END
GO
CREATE PROCEDURE updateIngredient
	@ingredientName VARCHAR(255),
	@ingredientDescription VARCHAR(255),
	@ingredientId INT
AS
UPDATE 
	ingredient
SET
	ingredientName = @ingredientName,
	ingredientDescription = @ingredientDescription
WHERE
	ingredientId = @ingredientId
SELECT
	@ingredientId AS ingredientId	
GO

/* ----------------------------------------------
** ----------------------------------------------
** recipe
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createRecipe
** Useage: EXEC createRecipe
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'createRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipe]
END
GO
CREATE PROCEDURE createRecipe(
	@difficultyId INT,	
	@recipeDuration INT,
	@recipeDescription VARCHAR(255),
	@recipeDirections VARCHAR(255),
	@recipeName VARCHAR(255),
	@recipePhotoUrl VARCHAR(255),
	@recipeYield INT
)
AS
INSERT INTO recipe (
	difficultyId,	
	recipeDuration,
	recipeDescription,
	recipeDirections,
	recipeName,
	recipePhotoUrl,
	recipeYield
)
SELECT
	@difficultyId,	
	@recipeDuration,
	@recipeDescription,
	@recipeDirections,
	@recipeName,
	@recipePhotoUrl,
	@recipeYield

SELECT
	r.recipeId
FROM
	recipe r
WHERE
	r.recipeName = @recipeName
	AND
	r.recipeDescription = @recipeDescription
GO

/* ----------------------------------------------
** Name: deleteRecipe
** Useage: EXEC deleteRecipe @recipeId = 1
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'deleteRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipe
END
GO
CREATE PROCEDURE deleteRecipe(
	@recipeId INT
)
AS
EXEC deleteRecipeEquipments @recipeId
EXEC deleteRecipeIngredients @recipeId
EXEC deleteRecipeTags @recipeId	
DELETE FROM
	dbo.recipe
WHERE
	recipeId = @recipeId
GO

/* ----------------------------------------------
** Name: retrieveRecipes
** Useage: EXEC retrieveRecipes @recipeTagId = 9, @recipeDifficultyId = 2, @recipeCookTime = 60
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'retrieveRecipes'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveRecipes]
END
GO
CREATE PROCEDURE retrieveRecipes(
	@recipeTagId INT = NULL,
	@recipeDifficultyId INT = NULL,
	@recipeDuration INT = NULL
)
AS 
DECLARE @query NVARCHAR(512)
SET @query = '
	SELECT
		r.recipeId,
		r.recipeName,
		r.recipeDescription,
		r.recipePhotoUrl,
		r.recipeDuration,
		r.recipeYield,
		d.difficultyName
	FROM
		recipe AS r
		LEFT OUTER JOIN
		difficulty AS d
			ON r.difficultyId = d.difficultyId
		LEFT OUTER JOIN
		recipe_tag rt
			ON r.recipeId = rt.recipeId'			
IF @recipeTagId <> '' OR @recipeDifficultyId <> '' OR @recipeDuration <> ''
	SET @query = @query + '
	WHERE'	
IF @recipeTagId <> ''
	SET @query = @query + '
		rt.tagId = ' + CAST(@recipeTagId AS VARCHAR(8))		
IF @recipeTagId <> '' AND @recipeDifficultyId <> ''
	SET @query = @query + '
		AND'		
IF @recipeDifficultyId <> ''
	SET @query = @query + '
		d.difficultyId >= ' + CAST(@recipeDifficultyId AS VARCHAR(1))		
IF (@recipeTagId <> '' OR @recipeDifficultyId <> '') AND @recipeDuration <> ''
	SET @query = @query + '
		AND'		
IF @recipeDuration <> ''
	SET @query = @query + '
		r.recipeDuration >= ' + CAST(@recipeDuration AS VARCHAR(3))
EXEC SP_EXECUTESQL @query 
GO

/* ----------------------------------------------
** Name: updateRecipe
** Useage: EXEC updateRecipe @recipeId = 2, @
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'updateRecipe'
)
BEGIN
	DROP PROCEDURE [dbo].updateRecipe
END
GO
CREATE PROCEDURE updateRecipe	
	@difficultyId INT,	
	@recipeDuration INT,
	@recipeDescription VARCHAR(255),
	@recipeDirections VARCHAR(255),
	@recipeId INT,
	@recipeName VARCHAR(255),
	@recipePhotoUrl VARCHAR(255),
	@recipeYield INT
AS
UPDATE 
	recipe
SET
	difficultyId = @difficultyId,	
	recipeDuration = @recipeDuration,
	recipeDescription = @recipeDescription,
	recipeDirections = @recipeDirections,
	recipeName = @recipeName,
	recipePhotoUrl = @recipePhotoUrl,
	recipeYield = @recipeYield
WHERE
	recipeId = @recipeId		
GO

/* ----------------------------------------------
** ----------------------------------------------
** tag
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createTag
** Useage: EXEC createTag @tagName='Savory', @tagIdParent=8
** ---------------------------------------------- */
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
	@tagIdParent INT = NULL
AS
INSERT INTO tag (
	tagName,
	tagIdParent
)
SELECT
	@tagName,
	@tagIdParent
SELECT
	t.tagId
FROM
	tag t
WHERE
	t.tagName = @tagName
	AND
	t.tagIdParent = @tagIdParent	
GO

/* ----------------------------------------------
** Name: retrieveTags
** Useage: EXEC retrieveTags
** ---------------------------------------------- */
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
	tagIdParent
FROM
	dbo.tag	
GO

/* ----------------------------------------------
** Name: updateTag
** Useage: EXEC updateTag @tagName = 'Flavor Profile' @tagParentId
** ---------------------------------------------- */
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

/* ----------------------------------------------
** ----------------------------------------------
** unit
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createUnits
** Useage: EXEC createUnits @unitTypeId=1, @unitName='liter', @unitAbbreviation='l'
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'createUnits'
)
BEGIN
	DROP PROCEDURE [dbo].createUnits
END
GO
CREATE PROCEDURE createUnits
	@unitTypeId INT,
	@unitName VARCHAR(255),
	@unitAbbreviation VARCHAR(255)
AS 
INSERT INTO unit (
	unitTypeId,	
	unitName,
	unitAbbreviation
)
SELECT
	@unitTypeId,	
	@unitName,
	@unitAbbreviation	
GO

/* ----------------------------------------------
** Name: retrieveUnits
** Useage: EXEC retrieveUnits
** ---------------------------------------------- */
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

/* ----------------------------------------------
** Name: retrieveUnitTypes
** Useage: EXEC retrieveUnitTypes
** ---------------------------------------------- */
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

/* ----------------------------------------------
** ----------------------------------------------
** recipe equipments
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createRecipeEquipment
** Useage: EXEC createRecipeEquipment
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'createRecipeEquipment'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipeEquipment]
END
GO
CREATE PROCEDURE createRecipeEquipment(
	@recipeId INT,	
	@equipmentId INT
)
AS
INSERT INTO recipe_equipment (
	recipeId,	
	equipmentId
)
SELECT
	@recipeId,	
	@equipmentId
GO

/* ----------------------------------------------
** Name: deleteRecipeEquipments
** Useage: EXEC deleteRecipeEquipments @recipeId = 1
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'deleteRecipeEquipments'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipeEquipments
END
GO
CREATE PROCEDURE deleteRecipeEquipments(
	@recipeId INT
)
AS
DELETE FROM
	dbo.recipe_equipment
WHERE
	recipeId = @recipeId
GO

/* ----------------------------------------------
** Name: retrieveRecipeEquipments
** Useage: EXEC retrieveRecipeEquipments @recipeId = 1
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'retrieveRecipeEquipments'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveRecipeEquipments
END
GO
CREATE PROCEDURE retrieveRecipeEquipments (
	@recipeId INT
)
AS 
SELECT	
	e.equipmentDescription,
	e.equipmentId,
	e.equipmentName
FROM
	recipe_equipment AS re
	LEFT OUTER JOIN
	equipment AS e
		ON re.equipmentId = e.equipmentId
WHERE
	re.recipeId = @recipeId	
GO

/* ----------------------------------------------
** ----------------------------------------------
** recipe ingredients
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createRecipeIngredient
** Useage: EXEC createRecipeIngredient
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'createRecipeIngredient'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipeIngredient]
END
GO
CREATE PROCEDURE createRecipeIngredient(
	@recipeId INT,	
	@ingredientId INT,
	@unitId INT,
	@quantity INT
)
AS
INSERT INTO recipe_ingredient (
	recipeId,	
	ingredientId,
	unitId,
	quantity
)
SELECT
	@recipeId,	
	@ingredientId INT,
	@unitId INT,
	@quantity INT
GO

/* ----------------------------------------------
** Name: deleteRecipeIngredients
** Useage: EXEC deleteRecipeIngredients @recipeId = 1
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'deleteRecipeIngredients'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipeIngredients
END
GO
CREATE PROCEDURE deleteRecipeIngredients(
	@recipeId INT
)
AS
DELETE FROM
	dbo.recipe_ingredient
WHERE
	recipeId = @recipeId
GO

/* ----------------------------------------------
** Name: retrieveRecipeIngredients
** Useage: CALL retrieveRecipeIngredients(1)
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'retrieveRecipeIngredients'
)
BEGIN
	DROP PROCEDURE [dbo].retrieveRecipeIngredients
END
GO
CREATE PROCEDURE retrieveRecipeIngredients (
	@recipeId INT
)
AS 
SELECT
	ri.quantity,
	u.unitName,
	u.unitId,
	u.unitAbbreviation,
	i.ingredientId,
	i.ingredientName,
	i.ingredientDescription
FROM
	recipe AS r
	LEFT OUTER JOIN
	recipe_ingredient AS ri
		ON r.recipeId = ri.recipeId
	LEFT OUTER JOIN
	ingredient AS i
		ON ri.ingredientId = i.ingredientId
	LEFT OUTER JOIN
	unit AS u
		ON ri.unitId = u.unitId
WHERE
	r.recipeId = @recipeId;
GO

/* ----------------------------------------------
** ----------------------------------------------
** recipe tags
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** Name: createRecipeTag
** Useage: EXEC createRecipeTag
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'createRecipeTag'
)
BEGIN
	DROP PROCEDURE [dbo].[createRecipeTag]
END
GO
CREATE PROCEDURE createRecipeTag(
	@recipeId INT,	
	@tagId INT
)
AS
INSERT INTO recipe_tag (
	recipeId,	
	tagId
)
SELECT
	@recipeId,	
	@tagId
GO

/* ----------------------------------------------
** Name: deleteRecipeTags
** Useage: EXEC deleteRecipeTags @recipeId = 1
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'deleteRecipeTags'
)
BEGIN
	DROP PROCEDURE [dbo].deleteRecipeTags
END
GO
CREATE PROCEDURE deleteRecipeTags(
	@recipeId INT
)
AS
DELETE FROM
	dbo.recipe_tag
WHERE
	recipeId = @recipeId
GO

/* ----------------------------------------------
** Name: retrieveRecipeTags
** Useage: EXEC retrieveRecipeTags @recipeId = 1
** ---------------------------------------------- */
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
		ROUTINE_NAME = 'retrieveRecipeTags'
)
BEGIN
	DROP PROCEDURE [dbo].[retrieveRecipeTags]
END
GO
CREATE PROCEDURE retrieveRecipeTags (
	@recipeId INT
)
AS 
SELECT
	t.tagId,
	t.tagName
FROM
	recipe_tag AS rt
	LEFT OUTER JOIN
	tag AS t
		ON rt.tagId = t.tagId
WHERE
	rt.recipeId = @recipeId
GO

/* ----------------------------------------------
** ----------------------------------------------
** ----------------------------------------------
** Recipe Database Initial Data Population
** ----------------------------------------------
** ----------------------------------------------
** ---------------------------------------------- */

/* ----------------------------------------------
** difficulty
** ---------------------------------------------- */
INSERT INTO difficulty (
	difficultyName
)
VALUES
( 
	'Easy'
), -- 1
(  
	'Medium'
), -- 2
(
	'Difficult'
) -- 3
GO

/* ----------------------------------------------
** equipment
** ---------------------------------------------- */
EXEC createEquipment @equipmentName='Appliances', @equipmentDescription='Machines used in cooking (e.g. oven, air fryer, etc...)'
GO -- 1
EXEC createEquipment @equipmentName='Food Preparation', @equipmentDescription='Other items used in cooking (e.g. cutting board, spatula, etc...)'
GO -- 2
EXEC createEquipment @equipmentName='Servingware', @equipmentDescription='Items used to serve food once it has been prepared (e.g. plates, utensils, etc...)'
GO -- 3
EXEC createEquipment @equipmentName='Dutch Oven', @equipmentDescription='A heavy, wide, fairly shallow pot with a tight fitting lid', @equipmentIdParent=2
GO
EXEC createEquipment @equipmentName='Burner', @equipmentDescription='A heat source upon which pots, pans or other vessels can be placed', @equipmentIdParent=1
GO
EXEC createEquipment @equipmentName='Cutting Board', @equipmentDescription='A wooden or plastic board used to protect the countertop and/or assist in cleaning in food preparation', @equipmentIdParent=1
GO
EXEC createEquipment @equipmentName='Chefs Knife', @equipmentDescription='A large general utility knife used in food preparation', @equipmentIdParent=2
GO
EXEC createEquipment @equipmentName='Insta Pot', @equipmentDescription='A pressure cooker with a built in burner and timer', @equipmentIdParent=1
GO
EXEC createEquipment @equipmentName='Bowl', @equipmentDescription='A semi spherical dish used for serving food', @equipmentIdParent=3
GO

/* ----------------------------------------------
** ingredient
** ---------------------------------------------- */
EXEC createIngredient @ingredientName='Basic', @ingredientDescription='A type reserved for the most basic of ingredients (e.g. Water)'
GO -- 1
EXEC createIngredient @ingredientName='Herbs and Spices', @ingredientDescription='Any seed, fruit, bark, or other substance in a form primarily used for flavoring or coloring food'
GO -- 2
EXEC createIngredient @ingredientName='Meat', @ingredientDescription='Animal tissue, often muscle, that is eaten as food'
GO -- 3
EXEC createIngredient @ingredientName='Grain', @ingredientDescription='A grass cultivated for it''s edible grain'
GO -- 4
EXEC createIngredient @ingredientName='Fruit', @ingredientDescription='The fleshy or dry ripened ovary of a flowering plant, enclosing the seed or seeds'
GO -- 5
EXEC createIngredient @ingredientName='Vegetable', @ingredientDescription='Any other part of a plant that is not fruit, such as the leaves, stems, roots, and bulbs'
GO -- 6
EXEC createIngredient @ingredientName='Water', @ingredientDescription='Perhaps the most basic ingredient', @ingredientIdParent=1
GO -- 7
EXEC createIngredient @ingredientName='Vegetable Oil', @ingredientDescription='Oil extracted from the seeds or other parts of edible plants', @ingredientIdParent=1
GO -- 8
EXEC createIngredient @ingredientName='Kosher Salt', @ingredientDescription='A coarse edible salt, usually without common additives such as iodine', @ingredientIdParent=2
GO -- 9
EXEC createIngredient @ingredientName='Black Pepper', @ingredientDescription='The dried seed of a flowering vine in the family Piperaceae', @ingredientIdParent=2
GO -- 10
EXEC createIngredient @ingredientName='Garlic', @ingredientDescription='A species of bulbous flowing plant in the genus Allium', @ingredientIdParent=2
GO -- 11
EXEC createIngredient @ingredientName='Dry Garbanzo Beans', @ingredientDescription='Also known as the chick pea, dried garbanzo beans are round, beige in color, and are about 1 cm in circumference', @ingredientIdParent=4
GO -- 12
EXEC createIngredient @ingredientName='Fire Roasted Green Chilies', @ingredientDescription='Available fresh, frozen or canned, green chilies (e.g. Hatch) are roasted over an open flame so the skin peels off', @ingredientIdParent=6
GO -- 13
EXEC createIngredient @ingredientName='Long Grain Wild Rice Blend', @ingredientDescription='A mix of various types of long grain rice, including a black wild rice', @ingredientIdParent=4
GO -- 14
EXEC createIngredient @ingredientName='Chicken', @ingredientDescription='A medium sized domesticated flightless bird', @ingredientIdParent=3
GO -- 15


/* ----------------------------------------------
** tag
** ---------------------------------------------- */
EXEC createTag @tagName='Cusine Type' 
GO -- 1
EXEC createTag @tagName='Flavor Profile'
GO -- 2
EXEC createTag @tagName='Meal'
GO -- 3
EXEC createTag @tagName='American South West', @tagIdParent=1
GO -- 4
EXEC createTag @tagName='Asian', @tagIdParent=1
GO -- 5
EXEC createTag @tagName='Cajun', @tagIdParent=1
GO -- 6
EXEC createTag @tagName='BBQ', @tagIdParent=1
GO -- 7
EXEC createTag @tagName='Mexican', @tagIdParent=1
GO -- 8
EXEC createTag @tagName='Indian', @tagIdParent=1
GO -- 9

/* ----------------------------------------------
** unit
** ---------------------------------------------- */
INSERT INTO unitType (
	unitTypeName
)
VALUES 
(
	'Metric'
), -- 1
(
	'Imperial'
), -- 2
(
	'Natural'
) -- 3

GO

EXEC createUnits @unitTypeId=1, @unitName='Liter', @unitAbbreviation='l'
GO -- 1
EXEC createUnits @unitTypeId=1, @unitName='Gram', @unitAbbreviation='g'
GO -- 2
EXEC createUnits @unitTypeId=1, @unitName='Kilogram', @unitAbbreviation='kg'
GO -- 3
EXEC createUnits @unitTypeId=1, @unitName='Mililiter', @unitAbbreviation='ml'
GO -- 4
EXEC createUnits @unitTypeId=1, @unitName='Celsius', @unitAbbreviation='C'
GO -- 5
EXEC createUnits @unitTypeId=3, @unitName='Clove', @unitAbbreviation='n/a'
GO -- 6
EXEC createUnits @unitTypeId=3, @unitName='Head', @unitAbbreviation='n/a'
GO -- 7
EXEC createUnits @unitTypeId=3, @unitName='Whole', @unitAbbreviation='n/a'
GO -- 8

/* ----------------------------------------------
** recipe
** ---------------------------------------------- */
EXEC createRecipe 
	@difficultyId=2,	
	@recipeDuration=60,
	@recipeDescription='A slightly spicy soup made with chicken, rice, and garbanzo beans',
	@recipeDirections='yada yada',
	@recipeName='Bowl of the Wife of Kit Carson',
	@recipePhotoUrl='https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg',
	@recipeYield=6
GO -- 1

EXEC createRecipeEquipment @recipeId=1, @equipmentId=4
GO
EXEC createRecipeEquipment @recipeId=1, @equipmentId=5
GO
EXEC createRecipeEquipment @recipeId=1, @equipmentId=6
GO
EXEC createRecipeEquipment @recipeId=1, @equipmentId=7
GO
EXEC createRecipeEquipment @recipeId=1, @equipmentId=8
GO
EXEC createRecipeEquipment @recipeId=1, @equipmentId=9
GO

EXEC createRecipeIngredient @recipeId=1, @ingredientId=15, @quantity=1, @unitId=8
GO
EXEC createRecipeIngredient @recipeId=1, @ingredientId=12, @quantity=250, @unitId=4
GO

EXEC createRecipeTag @recipeId=1, @tagId=4