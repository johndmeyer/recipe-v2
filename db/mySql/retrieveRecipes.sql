/*
Name: retrieveRecipes
Useage: CALL retrieveRecipes(-60, 0, 0)
*/

USE recipe;

DROP PROCEDURE IF EXISTS retrieveRecipes;

DELIMITER //

CREATE PROCEDURE retrieveRecipes(
	recipeCookTime INT,
    recipeDifficultyId INT,
	recipeTagId INT
)
BEGIN
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

	-- SELECT @query; -- Uncomment for debugging

	PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;






