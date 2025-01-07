/*
Name: retrieveRecipes
Useage: CALL retrieveRecipes(1, 2, 60)
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveRecipes;

DELIMITER //

CREATE PROCEDURE retrieveRecipes(
	recipeTagId INT,
	recipeDifficultyId INT,
	recipeCookTime INT
)
BEGIN
	SET recipeCookTime = 30;

	SET @query = '
		SELECT
			r.recipeId,
			r.recipeName,
			r.recipeDescription,
			r.recipePhotoUrl,
			r.recipeCookTime,
			r.recipeYield,
			d.difficultyName
		FROM
			recipe AS r
			LEFT OUTER JOIN
			difficulty AS d
				ON r.difficultyId = d.difficultyId
			LEFT OUTER JOIN
			recipe_tag rt
				ON r.recipeId = rt.recipeId';
			
	IF 
--     @recipeTagId <> '' OR 
--     @recipeDifficultyId <> '' OR 
    recipeCookTime <> '' THEN
		SET @query = @query + '
		WHERE';
	END IF;
-- 	
-- IF @recipeTagId <> ''
-- 	SET @query = @query + '
-- 		rt.tagId = ' + CAST(@recipeTagId AS VARCHAR(8))
-- 		
-- IF @recipeTagId <> '' AND @recipeDifficultyId <> ''
-- 	SET @query = @query + '
-- 		AND'
-- 		
-- IF @recipeDifficultyId <> ''
-- 	SET @query = @query + '
-- 		d.difficultyId >= ' + CAST(@recipeDifficultyId AS VARCHAR(1))
-- 		
-- IF (@recipeTagId <> '' OR @recipeDifficultyId <> '') AND @recipeCookTime <> ''
-- 	SET @query = @query + '
-- 		AND'
-- 		
	IF recipeCookTime <> '' THEN
		SET @query = @query + '
			r.recipeCookTime >= ' + CAST(recipeCookTime AS CHAR(3));
	END IF;
 
	PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;





