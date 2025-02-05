using DataModels;
using Dapper;

namespace Data
{
    public interface IDataRecipe
    {
        Task<IEnumerable<RecipeFull?>> CreateRecipe(RecipeFull recipe);
        void DeleteRecipe(int recipeId);
        Task<IEnumerable<RecipeFull?>> RetrieveRecipe(int recipeId);
        Task<IEnumerable<RecipeBase>> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId);
        Task<IEnumerable<RecipeFull?>> UpdateRecipe(RecipeFull recipe);

    } // end interface
    
    public class DataRecipe(IDapperDbConnection dapperDbConnection) : DataBase(dapperDbConnection), IDataRecipe
    {
        public async Task<IEnumerable<RecipeFull?>> CreateRecipe(RecipeFull recipe)
        {
            // This seems like the wrong way to do this - should use a transaction here - need to come back and fix it
            var recipeId = 0;
        
            var recipeQueryName = "createRecipe";
            var recipeArguments = new List<QueryArguments>
            {
                new QueryArguments(name: "recipeDescription", value: recipe.Recipe.RecipeDescription, isInt: false),
                new QueryArguments(name: "recipeDifficultyId", value: recipe.Recipe.RecipeDifficultyId.ToString(), isInt: true),
                new QueryArguments(name: "recipeDirections", value: recipe.Recipe.RecipeDirections, isInt: false),
                new QueryArguments(name: "recipeDuration", value: recipe.Recipe.RecipeDuration.ToString(), isInt: true),
                new QueryArguments(name: "recipeName", value: recipe.Recipe.RecipeName, isInt: false),
                new QueryArguments(name: "recipePhotoUrl", value: recipe.Recipe.RecipePhotoUrl, isInt: false),
                new QueryArguments(name: "recipeYield", value: recipe.Recipe.RecipeYield.ToString(), isInt: true),
            };
            
            var recipeQuery = BuildQuery(recipeQueryName, recipeArguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                recipeId = connection.QueryAsync<int>(recipeQuery).Result.FirstOrDefault();
            }

            if (recipeId != 0)
            {
                foreach (var equipment in recipe.RecipeEquipments)
                {
                    var queryName = "createRecipeEquipment";
                    var arguments = new List<QueryArguments>
                    {
                        new QueryArguments(name: "recipeId", value: recipeId.ToString(), isInt: true),
                        new QueryArguments(name: "equipmentId", value: equipment.EquipmentId.ToString(), isInt: true),
                    };
                    
                    var query = BuildQuery(queryName, arguments);
            
                    using (var connection = _dapperDbConnection.CreateConnection())
                    {
                        await connection.QueryAsync<object>(query);
                    }
                }
                
                foreach (var ingredient in recipe.RecipeIngredients)
                {
                    var queryName = "createRecipeIngredient";
                    var arguments = new List<QueryArguments>
                    {
                        new QueryArguments(name: "recipeId", value: recipeId.ToString(), isInt: true),
                        new QueryArguments(name: "ingredientId", value: ingredient.IngredientId.ToString(), isInt: true),
                        new QueryArguments(name: "unitId", value: ingredient.UnitId.ToString(), isInt: true),
                        new QueryArguments(name: "quantity", value: ingredient.Quantity.ToString(), isInt: true),
                    };
                    
                    var query = BuildQuery(queryName, arguments);
            
                    using (var connection = _dapperDbConnection.CreateConnection())
                    {
                        await connection.QueryAsync<object>(query);
                    }
                }
                
                foreach (var tag in recipe.RecipeTags)
                {
                    var queryName = "createRecipeTag";
                    var arguments = new List<QueryArguments>
                    {
                        new QueryArguments(name: "recipeId", value: recipeId.ToString(), isInt: true),
                        new QueryArguments(name: "tagId", value: tag.TagId.ToString(), isInt: true),
                    };
                    
                    var query = BuildQuery(queryName, arguments);
            
                    using (var connection = _dapperDbConnection.CreateConnection())
                    {
                        await connection.QueryAsync<object>(query);
                    }
                }
            }

            return await RetrieveRecipe(recipeId);
        } // end

        public async void DeleteRecipe(int recipeId)
        {
            var queryName = "deleteRecipe";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "RecipeId", value: recipeId.ToString(), isInt: true)
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<object>(query);
            }
        } // end

        public async Task<IEnumerable<RecipeFull?>> RetrieveRecipe(int recipeId)
        {
            var queryName = "retrieveRecipe";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "RecipeId", value: recipeId.ToString(), isInt: true)
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<RecipeFull>(query);
            }
        } // end

        public async Task<IEnumerable<RecipeBase>> RetrieveRecipes(int? recipeDuration, int? recipeDifficultyId, int? recipeTagId)
        {
            var queryName = "retrieveRecipes";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "RecipeDuration", value: recipeDuration?.ToString() ?? "", isInt: true),
                new QueryArguments(name: "RecipeDifficultyId", value: recipeDifficultyId?.ToString() ?? "", isInt: true),
                new QueryArguments(name: "RecipeTagId", value: recipeTagId?.ToString() ?? "", isInt: true),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<RecipeBase>(query);
            }
        } // end

        public async Task<IEnumerable<RecipeFull?>> UpdateRecipe(RecipeFull recipe)
        {
            // This seems like the wrong way to do this - should use a transaction here - need to come back and fix it
            var recipeQueryName = "updateRecipe";
            var recipeArguments = new List<QueryArguments>
            {
                
                new QueryArguments(name: "recipeDescription", value: recipe.Recipe.RecipeDescription, isInt: false),
                new QueryArguments(name: "recipeDifficultyId", value: recipe.Recipe.RecipeDifficultyId.ToString(), isInt: true),
                new QueryArguments(name: "recipeDirections", value: recipe.Recipe.RecipeDirections, isInt: false),
                new QueryArguments(name: "recipeDuration", value: recipe.Recipe.RecipeDuration.ToString(), isInt: true),
                new QueryArguments(name: "recipeId", value: recipe.Recipe.RecipeDescription, isInt: true),
                new QueryArguments(name: "recipeName", value: recipe.Recipe.RecipeName, isInt: false),
                new QueryArguments(name: "recipePhotoUrl", value: recipe.Recipe.RecipePhotoUrl, isInt: false),
                new QueryArguments(name: "recipeYield", value: recipe.Recipe.RecipeYield.ToString(), isInt: true),
            };
            
            var recipeQuery = BuildQuery(recipeQueryName, recipeArguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<int>(recipeQuery);
            }
        
            // Delete all existing equipments
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<string>("deleteRecipeEquipments");
            }
            
            foreach (var equipment in recipe.RecipeEquipments)
            {
                var queryName = "createRecipeEquipment";
                var arguments = new List<QueryArguments>
                {
                    new QueryArguments(name: "recipeId", value: recipe.Recipe.RecipeId.ToString(), isInt: true),
                    new QueryArguments(name: "equipmentId", value: equipment.EquipmentId.ToString(), isInt: true),
                };
                
                var query = BuildQuery(queryName, arguments);
        
                using (var connection = _dapperDbConnection.CreateConnection())
                {
                    await connection.QueryAsync<object>(query);
                }
            }
            
            // Delete all existing ingredients
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<string>("deleteRecipeIngredients");
            }
            
            foreach (var ingredient in recipe.RecipeIngredients)
            {
                var queryName = "createRecipeIngredient";
                var arguments = new List<QueryArguments>
                {
                    new QueryArguments(name: "recipeId", value: recipe.Recipe.RecipeId.ToString(), isInt: true),
                    new QueryArguments(name: "ingredientId", value: ingredient.IngredientId.ToString(), isInt: true),
                    new QueryArguments(name: "unitId", value: ingredient.UnitId.ToString(), isInt: true),
                    new QueryArguments(name: "quantity", value: ingredient.Quantity.ToString(), isInt: true),
                };
                
                var query = BuildQuery(queryName, arguments);
        
                using (var connection = _dapperDbConnection.CreateConnection())
                {
                    await connection.QueryAsync<object>(query);
                }
            }
            
            // Delete all existing tags
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<string>("deleteRecipeTags");
            }
            
            foreach (var tag in recipe.RecipeTags)
            {
                var queryName = "createRecipeTag";
                var arguments = new List<QueryArguments>
                {
                    new QueryArguments(name: "recipeId", value: recipe.Recipe.RecipeId.ToString(), isInt: true),
                    new QueryArguments(name: "tagId", value: tag.TagId.ToString(), isInt: true),
                };
                
                var query = BuildQuery(queryName, arguments);
        
                using (var connection = _dapperDbConnection.CreateConnection())
                {
                    await connection.QueryAsync<object>(query);
                }
            }

            return await RetrieveRecipe(recipe.Recipe.RecipeId);
        } // end
    } // end class
} // end namespace
