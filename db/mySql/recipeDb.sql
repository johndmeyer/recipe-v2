/*
*
* Recipe Database Creation
*
*/

/*
* CREATE DATABASE recipe; -- This step likely won't be neccessary when creating the database in AWS or other cloud providers
*/

USE recipe;

/* -------------------------------------------------------
** -------------------------------------------------------
** Recipe Database Table Creation
** -------------------------------------------------------
** ------------------------------------------------------- */

CREATE TABLE difficulty (
	difficultyId INT NOT NULL AUTO_INCREMENT,
	difficultyName VARCHAR(32) NOT NULL,
    PRIMARY KEY (difficultyId)
);

CREATE TABLE equipment (
	equipmentId INT AUTO_INCREMENT,
	equipmentName VARCHAR(255) NOT NULL, 
	equipmentParentId INT REFERENCES equipment(equipmentId),
	equipmentDescription VARCHAR (255) NOT NULL,
	equipmentPhotoUrl VARCHAR(255),
    PRIMARY KEY (equipmentId)
);

CREATE TABLE ingredient (
	ingredientId INT AUTO_INCREMENT,	
	ingredientName VARCHAR(255) NOT NULL,
	ingredientParentId INT REFERENCES ingredient(ingredientId),
	ingredientDescription VARCHAR(255) NOT NULL,
	ingredientPhotoUrl VARCHAR(255),
    PRIMARY KEY (ingredientId)
);

CREATE TABLE recipe (
	recipeId INT AUTO_INCREMENT,
	difficultyId INT NOT NULL,
	recipeName VARCHAR(255) NOT NULL,
	recipeDuration INT NOT NULL,
	recipeYield INT NOT NULL,
	recipeDescription VARCHAR(255) NOT NULL,
	recipeDirections VARCHAR(255) NOT NULL,
	recipePhotoUrl VARCHAR(255),
    PRIMARY KEY (recipeId),
    FOREIGN KEY (difficultyId) REFERENCES difficulty(difficultyId)
);

CREATE TABLE tag (
	tagId INT AUTO_INCREMENT,
	tagName VARCHAR(255) NOT NULL,
	tagParentId INT REFERENCES tag(tagId),
    PRIMARY KEY (tagId)
);

CREATE TABLE unitType (
	unitTypeId INT AUTO_INCREMENT, 
	unitTypeName VARCHAR(255) NOT NULL,
    PRIMARY KEY (unitTypeId)
);

CREATE TABLE unit (
	unitId INT AUTO_INCREMENT,
	unitTypeId INT NOT NULL,
	unitName VARCHAR(255) NOT NULL,
	unitAbbreviation VARCHAR(16) NOT NULL,
    PRIMARY KEY (unitId),
    FOREIGN KEY (unitTypeId) REFERENCES unitType(unitTypeId)
);

CREATE TABLE recipe_equipment (
	recipeId INT NOT NULL,
	equipmentId INT NOT NULL,
    FOREIGN KEY (recipeId) REFERENCES recipe(recipeId),
    FOREIGN KEY (equipmentId) REFERENCES equipment(equipmentId)
);

CREATE TABLE recipe_ingredient (
	recipeId INT NOT NULL,
	ingredientId INT NOT NULL,
	quantity INT NOT NULL,
	unitId INT,
    FOREIGN KEY (recipeId) REFERENCES recipe(recipeId),
    FOREIGN KEY (ingredientId) REFERENCES ingredient(ingredientId),
    FOREIGN KEY (unitId) REFERENCES unit(unitId)
);

CREATE TABLE recipe_tag (
	recipeId INT NOT NULL,
	tagId INT NOT NULL,
    FOREIGN KEY (recipeId) REFERENCES recipe(recipeId),
    FOREIGN KEY (tagId) REFERENCES tag(tagId)
);

/* -------------------------------------------------------
** -------------------------------------------------------
** Recipe Database Stored Procedure Creation
** -------------------------------------------------------
** ------------------------------------------------------- */

/* -------------------------------------------------------
** difficulty 
** ------------------------------------------------------- */

/*
Name: retrieveDifficulties
Useage: CALL retrieveDifficulties
*/
DROP PROCEDURE IF EXISTS retrieveDifficulties;
DELIMITER //
CREATE PROCEDURE retrieveDifficulties()
BEGIN	
	SELECT
		d.difficultyId,
		d.difficultyName
	FROM
		difficulty AS d;
END //
DELIMITER ;

/* -------------------------------------------------------
** equipment 
** ------------------------------------------------------- */

/*
Name: createEquipment
Useage: CALL createEquipment('Test Description','Test Name', 0)
*/
DROP PROCEDURE IF EXISTS createEquipment;
DELIMITER //
CREATE PROCEDURE createEquipment (
	equipmentDescription VARCHAR(255),
	equipmentName VARCHAR(255),	
	equipmentParentId INT
)
BEGIN
	IF equipmentParentId = 0 THEN 
		SET equipmentParentId = null; 
    END IF;

	INSERT INTO equipment (
		equipmentName,
		equipmentDescription,
		equipmentParentId
	)
	VALUES (
		equipmentName,
		equipmentDescription,
		equipmentParentId
	);

	SELECT
		e.equipmentId,
		e.equipmentParentId,
		e.equipmentName,
		e.equipmentDescription	
	FROM
		equipment e
	WHERE
		e.equipmentName = equipmentName
		AND
		e.equipmentDescription = equipmentDescription;
END //
DELIMITER ;

/*
Name: deleteEquipment
Useage: CALL deleteEquipment(11)
*/
DROP PROCEDURE IF EXISTS deleteEquipment;
DELIMITER //
CREATE PROCEDURE deleteEquipment(
	equipmentId INT
)
BEGIN
	DELETE FROM
		equipment e
	WHERE
		e.equipmentId = equipmentId;
END //
DELIMITER ;

/*
Name: retrieveEquipments
Useage: CALL retrieveEquipments
*/
DROP PROCEDURE IF EXISTS retrieveEquipments;
DELIMITER //
CREATE PROCEDURE retrieveEquipments()
BEGIN	
	SELECT
		e.equipmentId,
		e.equipmentName,
        e.equipmentParentId,
        e.equipmentDescription,
        e.equipmentPhotoUrl
	FROM
		equipment AS e;
END //
DELIMITER ;

/*
Name: updateEquipment
Useage: CALL updateEquipment('an enclosed compartment for cooking and heating food.',24,'Oven')
*/
DROP PROCEDURE IF EXISTS updateEquipment;
DELIMITER //
CREATE PROCEDURE updateEquipment (
	equipmentDescription VARCHAR(255),
    equipmentId INT,
	equipmentName VARCHAR(255)
)
BEGIN
	UPDATE 
		equipment e
	SET
		e.equipmentName = equipmentName,
		e.equipmentDescription = equipmentDescription
	WHERE
		e.equipmentId = equipmentId;
        
	SELECT
		e.equipmentDescription,
		e.equipmentId,
        e.equipmentName,
        e.equipmentParentId
	FROM
		equipment e
	WHERE
		e.equipmentId = equipmentId;
END //
DELIMITER ;

/* -------------------------------------------------------
** ingredient 
** ------------------------------------------------------- */

/*
Name: createIngredient
Useage: CALL createIngredient('Test Description','Test Name', 0)
*/
DROP PROCEDURE IF EXISTS createIngredient;
DELIMITER //
CREATE PROCEDURE createIngredient (
	ingredientDescription VARCHAR(255),
	ingredientName VARCHAR(255),	
	ingredientParentId INT
)
BEGIN
	IF ingredientParentId = 0 THEN 
		SET ingredientParentId = null; 
    END IF;

	INSERT INTO ingredient (
		ingredientName,
		ingredientDescription,
		ingredientParentId
	)
	VALUES (
		ingredientName,
		ingredientDescription,
		ingredientParentId
	);

	SELECT
		i.ingredientId,
		i.ingredientParentId,
		i.ingredientName,
		i.ingredientDescription	
	FROM
		ingredient i
	WHERE
		i.ingredientName = ingredientName
		AND
		i.ingredientDescription = ingredientDescription;
END //
DELIMITER ;

/*
Name: deleteIngredient
Useage: CALL deleteIngredient(24)
*/
DROP PROCEDURE IF EXISTS deleteIngredient;
DELIMITER //
CREATE PROCEDURE deleteIngredient(
	ingredientId INT
)
BEGIN
	DELETE FROM
		ingredient i
	WHERE
		i.ingredientId = ingredientId;
END //
DELIMITER ;

/*
Name: retrieveIngredients
Useage: CALL retrieveIngredients
*/
DROP PROCEDURE IF EXISTS retrieveIngredients;
DELIMITER //
CREATE PROCEDURE retrieveIngredients()
BEGIN	
	SELECT
		i.ingredientId,
		i.ingredientName,
        i.ingredientParentId,
        i.ingredientDescription,
        i.ingredientPhotoUrl
        
	FROM
		ingredient AS i;
END //
DELIMITER ;

/*
Name: updateIngredient
Useage: CALL updateIngredient('an enclosed compartment for cooking and heating food.',25,'Oven')
*/
DROP PROCEDURE IF EXISTS updateIngredient;
DELIMITER //
CREATE PROCEDURE updateIngredient (
	ingredientDescription VARCHAR(255),
    ingredientId INT,
	ingredientName VARCHAR(255)
)
BEGIN
	UPDATE 
		ingredient i
	SET
		i.ingredientName = ingredientName,
		i.ingredientDescription = ingredientDescription
	WHERE
		i.ingredientId = ingredientId;
	
	SELECT
		i.ingredientDescription,
		i.ingredientId,
        i.ingredientName,
        i.ingredientParentId
	FROM
		ingredient i
	WHERE
		i.ingredientId = ingredientId;
END //
DELIMITER ;

/* -------------------------------------------------------
** recipe 
** ------------------------------------------------------- */

/*
Name: createRecipe
Useage: CALL createRecipe('description',2,'directions',60,'name','photo url',6)
*/
DROP PROCEDURE IF EXISTS createRecipe;
DELIMITER //
CREATE PROCEDURE createRecipe(
	recipeDescription VARCHAR(255),
    recipeDifficultyId INT,
    recipeDirections VARCHAR(255),
    recipeDuration INT,
	recipeName VARCHAR(255),
	recipePhotoUrl VARCHAR(255),
	recipeYield INT
)
BEGIN
	INSERT INTO recipe (
		difficultyId,	
		recipeDuration,
		recipeDescription,
		recipeDirections,
		recipeName,
		recipePhotoUrl,
		recipeYield
	)
	VALUES (
		recipeDifficultyId,	
		recipeDuration,
		recipeDescription,
		recipeDirections,
		recipeName,
		recipePhotoUrl,
		recipeYield
	);

	SELECT
		r.recipeId
	FROM
		recipe r
	WHERE
		r.recipeName = recipeName
		AND
		r.recipeDescription = recipeDescription;
END //	
DELIMITER ;

/*
Name: deleteRecipe
Useage: CALL deleteRecipe(6)
*/
DROP PROCEDURE IF EXISTS deleteRecipe;
DELIMITER //
CREATE PROCEDURE deleteRecipe(
	recipeId INT
)
BEGIN
	CALL deleteRecipeEquipments(recipeId);

	CALL deleteRecipeIngredients(recipeId);

	CALL deleteRecipeTags(recipeId);
		
	DELETE FROM
		recipe r
	WHERE
		r.recipeId = recipeId;
END //
DELIMITER ;

/*
Name: retrieveRecipe
Useage: CALL retrieveRecipe(1)
*/
DROP PROCEDURE IF EXISTS retrieveRecipe;
DELIMITER //
CREATE PROCEDURE retrieveRecipe (
	recipeId INT
)
BEGIN
	SELECT
		d.difficultyName,
		r.difficultyId,
		r.recipeCookTime,
		r.recipeDescription,
		r.recipeDirections,
		r.recipeName,
		r.recipePhotoUrl,
		r.recipeYield
	FROM
		recipe.recipe AS r
		LEFT OUTER JOIN
		difficulty AS d
			ON r.difficultyId = d.difficultyId
	WHERE
		r.recipeId = recipeId;
        
        CALL retrieveRecipeIngredients(recipeId);
        
        CALL retrieveRecipeEquipments(recipeId);

		CALL retrieveRecipeTags(recipeId);
END //
DELIMITER ;

/*
Name: retrieveRecipes
Useage: CALL retrieveRecipes(-60, 0, 0)
*/
DROP PROCEDURE IF EXISTS retrieveRecipes;
DELIMITER //
CREATE PROCEDURE retrieveRecipes(	
    recipeDifficultyId INT,
    recipeDuration INT,
	recipeTagId INT
)
BEGIN
	SET @query = '
		SELECT
			d.difficultyName,
			r.recipeId,
			r.recipeName, 
			r.recipeDescription,
            r.recipeDuration,
			r.recipePhotoUrl,			
			r.recipeYield			
		FROM
			recipe AS r
			LEFT OUTER JOIN
			difficulty AS d
				ON r.difficultyId = d.difficultyId
			LEFT OUTER JOIN
			recipe_tag rt
				ON r.recipeId = rt.recipeId';

	IF
		recipeCookTime <> 0  OR
        recipeDifficultyId <> 0 OR
		recipeTagId <> 0 
	THEN
		SET @query = CONCAT(
			@query,
			' WHERE '
		);
	END IF;
    
    IF 
		recipeCookTime <> 0 
    THEN
 		SET @query = CONCAT(
			@query,
            ' r.recipeCookTime >= ',
            CAST(recipeCookTime AS CHAR(3))
		);
 	END IF;
    
    IF
		recipeCookTime <> 0 AND
        recipeDifficultyId <> 0
	THEN
		SET @query = CONCAT(
			@query,
            ' AND '
		);
	END IF;
    
    IF
		recipeDifficultyId <> 0
	THEN
		SET @query = CONCAT(
			@query,
            ' d.difficultyId >= ',
            CAST(recipeDifficultyId AS CHAR(1))
		);
	END IF;
    
    IF 
		(recipeCookTime <> 0 OR recipeDifficultyId <> 0) 
        AND 
        recipeTagId <> 0
	THEN
		SET @query = CONCAT(
			@query,
            ' AND '
		);
	END IF;
    
    IF
		recipeTagId <> 0
	THEN
		SET @query = CONCAT(
			@query,
            ' rt.tagId = ',
            CAST(recipeTagId AS CHAR(8))
		);
	END IF;

	PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

/*
Name: updateRecipe
Useage: CALL updateRecipe('description',2,'directions',60,6,'name','photo url',6)
*/
DROP PROCEDURE IF EXISTS updateRecipe;
DELIMITER //
CREATE PROCEDURE updateRecipe (
	recipeDescription VARCHAR(255),
    recipeDifficultyId INT,
    recipeDirections VARCHAR(255),
    recipeDuration INT,
    recipeId INT,
	recipeName VARCHAR(255),
	recipePhotoUrl VARCHAR(255),
	recipeYield INT
)
BEGIN
	UPDATE 
		recipe r
	SET
		r.difficultyId = recipeDifficultyId,		
		r.recipeDescription = recipeDescription,
        r.recipeDuration = recipeDuration,
		r.recipeDirections = recipeDirections,
		r.recipeName = recipeName,
		r.recipePhotoUrl = recipePhotoUrl,
		r.recipeYield = recipeYield
	WHERE
		r.recipeId = recipeId;
	
	SELECT recipeId;
END //	
DELIMITER ;

/* -------------------------------------------------------
** tag 
** ------------------------------------------------------- */

/*
Name: createTag
Useage: CALL createTag('Savory', 7)
*/
DROP PROCEDURE IF EXISTS createTag;
DELIMITER //
CREATE PROCEDURE createTag (
	tagName VARCHAR(255),	
	tagParentId INT
)
BEGIN
	IF tagParentId = 0 THEN 
		SET tagParentId = null; 
    END IF;

	INSERT INTO tag (
		tagName,
		tagParentId
	)
	VALUES (
		tagName,
		tagParentId
	);

	SELECT
		t.tagId,
		t.tagParentId,
		t.tagName	
	FROM
		tag t
	WHERE
		t.tagName = tagName;
END //
DELIMITER ;

/*
Name: deleteTag
Useage: CALL deleteTag(11)
*/
DROP PROCEDURE IF EXISTS deleteTag;
DELIMITER //
CREATE PROCEDURE deleteTag(
	tagId INT
)
BEGIN
	DELETE FROM
		tag t
	WHERE
		t.tagId = tagId;
END //
DELIMITER ;

/*
Name: retrieveTags
Useage: CALL retrieveTags
*/
DROP PROCEDURE IF EXISTS retrieveTags;
DELIMITER //
CREATE PROCEDURE retrieveTags ()
BEGIN	
	SELECT
		t.tagId,
		t.tagName,
        t.tagParentId
	FROM
		tag AS t;
END //
DELIMITER ;

/*
Name: updateTag
Useage: CALL updateTag(11,'Name')
*/
DROP PROCEDURE IF EXISTS updateTag;
DELIMITER //
CREATE PROCEDURE updateTag (
    tagId INT,
	tagName VARCHAR(255)
)
BEGIN
	UPDATE 
		tag t
	SET
		t.tagName = tagName
	WHERE
		t.tagId = tagId;
	
	SELECT
		t.tagId,
        t.tagName,
        t.tagParentId
	FROM
		tag t
	WHERE
		t.tagId = tagId;
END //
DELIMITER ;

/* -------------------------------------------------------
** unit 
** ------------------------------------------------------- */

/*
Name: retrieveUnits
Useage: CALL retrieveUnits(1)
*/
DROP PROCEDURE IF EXISTS retrieveUnits;
DELIMITER //
CREATE PROCEDURE retrieveUnits(
	unitTypeId INT
)
BEGIN	
	SELECT
		u.unitId,
		u.unitName,
        u.unitTypeId,
        u.unitAbbreviation,
        ut.unitTypeName
	FROM
		unit AS u
		LEFT OUTER JOIN
		unitType AS ut
			ON u.unitTypeId = ut.unitTypeId
	WHERE
		u.unitTypeId = unitTypeId
        OR
        u.unitTypeId = 3;
END //
DELIMITER ;

/*** unitType ***/
/*
Name: retrieveUnitTypes
Useage: CALL retrieveUnitTypes
*/
DROP PROCEDURE IF EXISTS retrieveUnitTypes;
DELIMITER //
CREATE PROCEDURE retrieveUnitTypes()
BEGIN	
	SELECT
		i.unitTypeId,
		i.unitTypeName
        
	FROM
		unitType AS i;
END //
DELIMITER ;

/* -------------------------------------------------------
** recipeEquipment 
** ------------------------------------------------------- */

/*
Name: createRecipeEquipment
Useage: CALL createRecipeEquipment(6,2,1,5)
*/
DROP PROCEDURE IF EXISTS createRecipeEquipment;
DELIMITER //
CREATE PROCEDURE createRecipeEquipment(
	recipeId INT,
    equipmentId INT
)
BEGIN
	INSERT INTO recipe_equipment (
		recipeId,	
		equipmentId
	)
	VALUES (
		recipeId,	
		equipmentId
	);
END //
DELIMITER ;

/*
Name: deleteRecipeEquipments
Useage: CALL deleteRecipeEquipments(5)
*/
DROP PROCEDURE IF EXISTS deleteRecipeEquipments;
DELIMITER //
CREATE PROCEDURE deleteRecipeEquipments(
	recipeId INT
)
BEGIN
	DELETE FROM
		recipe_equipment re
	WHERE
		re.recipeId = recipeId;
END //
DELIMITER ;

/*
Name: retrieveRecipeEquipments
Useage: CALL retrieveRecipeEquipments(1)
*/
DROP PROCEDURE IF EXISTS retrieveRecipeEquipments;
DELIMITER //
CREATE PROCEDURE retrieveRecipeEquipments (
	recipeId INT
)
BEGIN	
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
		re.recipeId = recipeId;
END //
DELIMITER ;

/* -------------------------------------------------------
** recipeIngredient 
** ------------------------------------------------------- */

/*
Name: createRecipeIngredient
Useage: CALL createRecipeIngredient(1,4,3,250)
*/
DROP PROCEDURE IF EXISTS createRecipeIngredient;
DELIMITER //
CREATE PROCEDURE createRecipeIngredient(
	recipeId INT,
    ingredientId INT,
    unitId INT,
    quantity INT
)
BEGIN
	IF unitId = 0 THEN 
		SET unitId = null; 
    END IF;
    
	INSERT INTO recipe_ingredient (
		recipeId,	
		ingredientId,
		unitId,
		quantity
	)
	VALUES (
		recipeId,	
		ingredientId,
		unitId,
		quantity
	);
END //
DELIMITER ;

/*
Name: deleteRecipeIngredients
Useage: CALL deleteRecipeIngredients(5)
*/
DROP PROCEDURE IF EXISTS deleteRecipeIngredients;
DELIMITER //
CREATE PROCEDURE deleteRecipeIngredients(
	recipeId INT
)
BEGIN
	DELETE FROM
		recipe_ingredient ri
	WHERE
		ri.recipeId = recipeId;
END //
DELIMITER ;

/*
Name: retrieveRecipeIngredients
Useage: CALL retrieveRecipeIngredients(1)
*/
DROP PROCEDURE IF EXISTS retrieveRecipeIngredients;
DELIMITER //
CREATE PROCEDURE retrieveRecipeIngredients (
	recipeId INT
)
BEGIN
	SELECT
		ri.quantity,
		u.unitName,
		u.unitId,
		u.unitAbbreviation,
		i.ingredientId,
		i.ingredientName,
		i.ingredientDescription
	FROM
		recipe.recipe AS r
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
		r.recipeId = recipeId;
END //
DELIMITER ;

/* -------------------------------------------------------
** recipeTag 
** ------------------------------------------------------- */

/*
Name: createRecipeTag
Useage: CALL createRecipeTag(6,2)
*/
DROP PROCEDURE IF EXISTS createRecipeTag;
DELIMITER //
CREATE PROCEDURE createRecipeTag(
	recipeId INT,
    tagId INT
)
BEGIN
	INSERT INTO recipe_tag (
		recipeId,	
		tagId
	)
	VALUES (
		recipeId,	
		tagId
	);
END //
DELIMITER ;

/*
Name: deleteRecipeTags
Useage: CALL deleteRecipeTags(5)
*/
DROP PROCEDURE IF EXISTS deleteRecipeTags;
DELIMITER //
CREATE PROCEDURE deleteRecipeTags(
	recipeId INT
)
BEGIN
	DELETE FROM
		recipe_tag rt
	WHERE
		rt.recipeId = recipeId;
END //
DELIMITER ;

/*
Name: retrieveRecipeTags
Useage: CALL retrieveRecipeTags(1)
*/
DROP PROCEDURE IF EXISTS retrieveRecipeTags;
DELIMITER //
CREATE PROCEDURE retrieveRecipeTags (
	recipeId INT
)
BEGIN	
	SELECT
		t.tagId,
		t.tagName
	FROM
		recipe_tag AS rt
		LEFT OUTER JOIN
		tag AS t
			ON rt.tagId = t.tagId
	WHERE
		rt.recipeId = recipeId;
END //
DELIMITER ;

/* -------------------------------------------------------
** -------------------------------------------------------
** Recipe Database Initial Data Population
** -------------------------------------------------------
** ------------------------------------------------------- */

/* -------------------------------------------------------
** difficulty 
** ------------------------------------------------------- */
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

/* -------------------------------------------------------
** equipment 
** ------------------------------------------------------- */
CALL createEquipment('Machines used in cooking (e.g. oven, air fryer, etc...)','Appliances', 0); -- 1
CALL createEquipment('Other items used in cooking (e.g. cutting board, spatula, etc...)','Food Preparation', 0); -- 2
CALL createEquipment('Items used to serve food once it has been prepared (e.g. plates, utensils, etc...)','Servingware', 0); -- 3
CALL createEquipment('A heavy, wide, fairly shallow pot with a tight fitting lid','Dutch Oven', 2);
CALL createEquipment('A heat source upon which pots, pans or other vessels can be placed','Burner', 2);
CALL createEquipment('A wooden or plastic board used to protect the countertop and/or assist in cleaning in food preparation','Cutting Board', 2);
CALL createEquipment('A large general utility knife used in food preparation','Chefs Knife', 2);
CALL createEquipment('A pressure cooker with a built in burner and timer','Insta Pot', 2);
CALL createEquipment('A semi spherical dish used for serving food','Bowl', 3);

/* -------------------------------------------------------
** ingredient 
** ------------------------------------------------------- */
CALL createIngredient('A type reserved for the most basic of ingredients (e.g. Water)','Basic', 0);
CALL createIngredient('Any seed, fruit, bark, or other substance in a form primarily used for flavoring or coloring food','Herbs and Spices', 0);
CALL createIngredient('Animal tissue, often muscle, that is eaten as food','Meat', 0);
CALL createIngredient('A grass cultivated for it''s edible grain','Grain', 0);
CALL createIngredient('The fleshy or dry ripened ovary of a flowering plant, enclosing the seed or seeds','Fruit', 0);
CALL createIngredient('Any other part of a plant that is not fruit, such as the leaves, stems, roots, and bulbs','Vegetable', 0);
CALL createIngredient('Perhaps the most basic ingredient','Water', 1);
CALL createIngredient('Oil extracted from the seeds or other parts of edible plants','Vegetable Oil', 1);
CALL createIngredient('A coarse edible salt, usually without common additives such as iodine','Kosher Salt', 2);
CALL createIngredient('The dried seed of a flowering vine in the family Piperaceae','Black Pepper', 2);
CALL createIngredient('A species of bulbous flowing plant in the genus Allium','Garlic', 2);
CALL createIngredient('Also known as the chick pea, dried garbanzo beans are round, beige in color, and are about 1 cm in circumference','Dry Garbanzo Beans', 6);
CALL createIngredient('Available fresh, frozen or canned, green chilies (e.g. Hatch) are roasted over an open flame so the skin peels off','Fire Roasted Green Chilies', 6);
CALL createIngredient('A mix of various types of long grain rice, including a black wild rice','Long Grain Wild Rice Blend', 4);
CALL createIngredient('A raw whole chicken that has been gutted and de-feathered','Chicken', 3);

/* -------------------------------------------------------
** tag 
** ------------------------------------------------------- */
CALL createTag('Cusine Type', 0); -- 1
CALL createTag('American South West', 1);
CALL createTag('Asian', 1);
CALL createTag('BBQ', 1);
CALL createTag('Cajun', 1);
CALL createTag('Indian', 1);
CALL createTag('Mexican', 1);

/* -------------------------------------------------------
** unitType
** ------------------------------------------------------- */
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

/* -------------------------------------------------------
** unit 
** ------------------------------------------------------- */
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

/* -------------------------------------------------------
** recipe 
** ------------------------------------------------------- */
CALL createRecipe(
	'A slightly spicy soup made with chicken, rice, and garbanzo beans',
    2,
    'Directions would go here',
    60,
    'Bowl of the Wife of Kit Carson',
    'https://centerofthewest.org/wp-content/uploads/2023/03/PW343_recipe-chicken-soup.jpg',
    6
); -- 1

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
	
