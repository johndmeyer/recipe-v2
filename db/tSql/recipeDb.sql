CREATE DATABASE recipe

GO

USE recipe

GO

CREATE TABLE difficulty (
	difficultyId INT IDENTITY(1,1) PRIMARY KEY,
	difficultyName VARCHAR(32) NOT NULL
)

GO

CREATE TABLE recipe (
	recipeId INT IDENTITY(1,1) PRIMARY KEY,
	difficultyId INT NOT NULL FOREIGN KEY REFERENCES difficulty(difficultyId),
	recipeName VARCHAR(255) NOT NULL,
	recipeCookTime INT NOT NULL,
	recipeYield INT NOT NULL,
	recipeDescription VARCHAR(255) NOT NULL,
	recipeDirections VARCHAR(255) NOT NULL,
	recipePhotoUrl VARCHAR(255)
)

GO

CREATE TABLE ingredient (
	ingredientId INT IDENTITY(1,1) PRIMARY KEY,	
	ingredientName VARCHAR(255) NOT NULL,
	ingredientParentId INT REFERENCES ingredient(ingredientId),
	ingredientDescription VARCHAR(255) NOT NULL,
	ingredientPhotoUrl VARCHAR(255)
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

CREATE TABLE equipment (
	equipmentId INT IDENTITY(1,1) PRIMARY KEY,
	equipmentName VARCHAR(255) NOT NULL, 
	equipmentParentId INT REFERENCES equipment(equipmentId),
	equipmentDescription VARCHAR (255) NOT NULL,
	equipmentPhotoUrl VARCHAR(255)
)

GO

CREATE TABLE recipe_equipment (
	recipeId INT NOT NULL FOREIGN KEY REFERENCES recipe(recipeId),
	equipmentId INT NOT NULL FOREIGN KEY REFERENCES equipment(equipmentId), 
)

GO

--DROP TABLE tag
CREATE TABLE tag (
	tagId INT IDENTITY(1,1) PRIMARY KEY,
	tagName VARCHAR(255) NOT NULL,
	tagParentId INT REFERENCES tag(tagId),
	isParent BIT NOT NULL
)

GO

--DROP TABLE recipe_tags
CREATE TABLE recipe_tag (
	recipeId INT NOT NULL FOREIGN KEY REFERENCES recipe(recipeId),
	tagId INT NOT NULL FOREIGN KEY REFERENCES tag(tagId)
)

--CREATE TABLE productBrand (
--	productBrandId INT IDENTITY(1,1) PRIMARY KEY,
--	productBrandName VARCHAR(255) NOT NULL,
--	productBrandDescription VARCHAR(255)
--)

--GO

--CREATE TABLE product (
--	productId INT IDENTITY(1,1) PRIMARY KEY,
--	productBrandId VARCHAR(255) NOT NULL,
--	productName VARCHAR(255) NOT NULL, 
--	productDescription VARCHAR(255)
--)

--GO

--CREATE TABLE ingredient_product (
--	ingredientId INT NOT NULL FOREIGN KEY REFERENCES ingredient(ingredientId),
--	productId INT NOT NULL FOREIGN KEY REFERENCES product(productId),
--)

--GO
