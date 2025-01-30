/*
Name: createRecipe
Useage: CALL createRecipe('description',2,'directions',60,'name','photo url',6)
*/

USE recipe;

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
		recipeCookTime,
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





