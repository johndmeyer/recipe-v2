using System.Data;
using Dapper;
using Microsoft.Data.SqlClient;
using static DataModels.DataModelsRecipe;

namespace Data
{
    public interface IDapperDbConnection
    {
        public IDbConnection CreateConnection();
    }

    public class DapperDbConnection : IDapperDbConnection
    {
        // TODO: Store the connection string somewhere more secure
        private string connString = "Server=tcp:recipe-db-server.database.windows.net,1433;Initial Catalog=recipe_db;Persist Security Info=False;User ID=recipe-db-admin;Password=AkcvW4aZ28hY843#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=90;";

        public DapperDbConnection() { }

        public IDbConnection CreateConnection()
        {
            return new SqlConnection(connString);
        }
    }

    public class DataRecipe : IDataRecipe
    {
        private readonly IDapperDbConnection _dapperDbConnection;

        public DataRecipe(IDapperDbConnection dapperDbConnection)
        {
            _dapperDbConnection = dapperDbConnection;
        }

        public async Task<IEnumerable<RecipeBase>> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId)
        {
            var query = "EXEC retrieveRecipes"; // TODO: implement query builder in base class

            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<RecipeBase>(query);
            }
        } // end
    } // end class
} // end namespace
