CREATE DATABASE recipe

GO

USE recipe

GO

CREATE TABLE difficulty (
	difficultyId INT NOT NULL AUTO_INCREMENT,
	difficultyName VARCHAR(32) NOT NULL,
    PRIMARY KEY (difficultyId)
)

GO

CREATE TABLE recipe (
	recipeId INT AUTO_INCREMENT,
	difficultyId INT NOT NULL,
	recipeName VARCHAR(255) NOT NULL,
	recipeCookTime INT NOT NULL,
	recipeYield INT NOT NULL,
	recipeDescription VARCHAR(255) NOT NULL,
	recipeDirections VARCHAR(255) NOT NULL,
	recipePhotoUrl VARCHAR(255),
    PRIMARY KEY (recipeId),
    FOREIGN KEY (difficultyId) REFERENCES difficulty(difficultyId)
)

GO

CREATE TABLE ingredient (
	ingredientId INT AUTO_INCREMENT,	
	ingredientName VARCHAR(255) NOT NULL,
	ingredientParentId INT REFERENCES ingredient(ingredientId),
	ingredientDescription VARCHAR(255) NOT NULL,
	ingredientPhotoUrl VARCHAR(255),
    PRIMARY KEY (ingredientId)
)

GO

CREATE TABLE unitType (
	unitTypeId INT AUTO_INCREMENT, 
	unitTypeName VARCHAR(255) NOT NULL,
    PRIMARY KEY (unitTypeId)
)

GO

CREATE TABLE unit (
	unitId INT AUTO_INCREMENT,
	unitTypeId INT NOT NULL,
	unitName VARCHAR(255) NOT NULL,
	unitAbbreviation VARCHAR(16) NOT NULL,
    PRIMARY KEY (unitId),
    FOREIGN KEY (unitTypeId) REFERENCES unitType(unitTypeId)
)

GO

CREATE TABLE recipe_ingredient (
	recipeId INT NOT NULL,
	ingredientId INT NOT NULL,
	quantity INT NOT NULL,
	unitId INT NOT NULL,
    FOREIGN KEY (recipeId) REFERENCES recipe(recipeId),
    FOREIGN KEY (ingredientId) REFERENCES ingredient(ingredientId),
    FOREIGN KEY (unitId) REFERENCES unit(unitId)
)

GO

CREATE TABLE equipment (
	equipmentId INT AUTO_INCREMENT,
	equipmentName VARCHAR(255) NOT NULL, 
	equipmentParentId INT REFERENCES equipment(equipmentId),
	equipmentDescription VARCHAR (255) NOT NULL,
	equipmentPhotoUrl VARCHAR(255),
    PRIMARY KEY (equipmentId)
)

GO

CREATE TABLE recipe_equipment (
	recipeId INT NOT NULL,
	equipmentId INT NOT NULL,
    FOREIGN KEY (recipeId) REFERENCES recipe(recipeId),
    FOREIGN KEY (equipmentId) REFERENCES equipment(equipmentId)
)

GO

CREATE TABLE tag (
	tagId INT AUTO_INCREMENT,
	tagName VARCHAR(255) NOT NULL,
	tagParentId INT REFERENCES tag(tagId),
    PRIMARY KEY (tagId)
)

GO

CREATE TABLE recipe_tag (
	recipeId INT NOT NULL,
	tagId INT NOT NULL,
    FOREIGN KEY (recipeId) REFERENCES recipe(recipeId),
    FOREIGN KEY (tagId) REFERENCES tag(tagId)
)

