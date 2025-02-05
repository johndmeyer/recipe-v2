using DataModels;
using Dapper;

namespace Data
{
    public interface IDataUnit
    {
        Task<IEnumerable<Unit>> RetrieveUnits(string unitTypeName);
        Task<IEnumerable<UnitType>> RetrieveUnitTypes();
    } // end interface
    
    public class DataUnit(IDapperDbConnection dapperDbConnection) : DataBase(dapperDbConnection), IDataUnit
    {
        public async Task<IEnumerable<Unit>> RetrieveUnits(string unitTypeName)
        {
            var queryName = "retrieveUnits";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "unitTypeName", value: unitTypeName, isInt: false),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Unit>(query);
            }
        } // end 

        public async Task<IEnumerable<UnitType>> RetrieveUnitTypes()
        {
            var queryName = "retrieveUnitTypes";

            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<UnitType>(queryName);
            }
        } // end
    } // end class
} // end namespace
