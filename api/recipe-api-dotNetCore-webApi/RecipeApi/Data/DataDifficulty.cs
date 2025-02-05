using DataModels;
using Dapper;
namespace Data
{
    public interface IDataDifficulty
    {
        Task<IEnumerable<Difficulty>> RetrieveDifficulties();
    } // end interface
    
    public class DataDifficulty(IDapperDbConnection dapperDbConnection) : DataBase(dapperDbConnection), IDataDifficulty
    {
        public async Task<IEnumerable<Difficulty>> RetrieveDifficulties()
        {
            var queryName = "retrieveDifficulties";
            var arguments = new List<QueryArguments>();
            
            var query = BuildQuery(queryName, arguments);

            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Difficulty>(query);
            }
        } // end
    } // end class
} // end namespace
