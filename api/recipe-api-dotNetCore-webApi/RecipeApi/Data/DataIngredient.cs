using DataModels;
using Dapper;

namespace Data
{
    public interface IDataIngredient
    {
        Task<IEnumerable<IngredientBase>> CreateIngredient(IngredientBase Ingredient);
        void DeleteIngredient(int IngredientId);
        Task<IEnumerable<IngredientBase>> RetrieveIngredients();
        Task<IEnumerable<IngredientBase>> UpdateIngredient(IngredientBase ingredient);

    } // end interface
    
    public class DataIngredient(IDapperDbConnection dapperDbConnection) : DataBase(dapperDbConnection), IDataIngredient
    {
        public async Task<IEnumerable<IngredientBase>> CreateIngredient(IngredientBase ingredient)
        {
            var queryName = "createIngredient";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "IngredientParentId", value: ingredient.IngredientIdParent.ToString(), isInt: true),
                new QueryArguments(name: "IngredientName", value: ingredient.IngredientName, isInt: false),
                new QueryArguments(name: "IngredientDescription", value: ingredient.IngredientDescription, isInt: false),
                new QueryArguments(name: "IngredientPhotoUrl", value: ingredient.IngredientPhotoUrl, isInt: false),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<IngredientBase>(query);
            }
        } // end

        public async void DeleteIngredient(int ingredientId)
        {
            var queryName = "deleteIngredient";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "IngredientId", value: ingredientId.ToString(), isInt: true)
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<object>(query);
            }
        } // end

        public async Task<IEnumerable<IngredientBase>> RetrieveIngredients()
        {
            var queryName = "retrieveIngredients";
            var arguments = new List<QueryArguments>();
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<IngredientBase>(query);
            }
        } // end

        public async Task<IEnumerable<IngredientBase>> UpdateIngredient(IngredientBase Ingredient)
        {
            var queryName = "updateIngredient";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "IngredientId", value: Ingredient.IngredientId.ToString(), isInt: true),
                new QueryArguments(name: "IngredientName", value: Ingredient.IngredientName, isInt: false),
                new QueryArguments(name: "IngredientDescription", value: Ingredient.IngredientDescription, isInt: false),
                new QueryArguments(name: "IngredientPhotoUrl", value: Ingredient.IngredientPhotoUrl, isInt: false),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<IngredientBase>(query);
            }
        } // end
    } // end class
} // end namespace
