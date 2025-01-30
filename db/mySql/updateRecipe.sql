/*
Name: updateRecipe
Useage: CALL updateRecipe('description',2,'directions',60,6,'name','photo url',6)
*/

USE recipe;

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
		r.recipeCookTime = recipeDuration,
		r.recipeDescription = recipeDescription,
		r.recipeDirections = recipeDirections,
		r.recipeName = recipeName,
		r.recipePhotoUrl = recipePhotoUrl,
		r.recipeYield = recipeYield
	WHERE
		r.recipeId = recipeId;
	
	SELECT recipeId;
END //
	
DELIMITER ;
