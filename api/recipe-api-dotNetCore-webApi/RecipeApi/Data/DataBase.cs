using System.Data;
using Microsoft.Data.SqlClient;

namespace Data
{
    public interface IDapperDbConnection
    {
        public IDbConnection CreateConnection();
    } // end interface
    
    public class DapperDbConnection : IDapperDbConnection
    {
        // TODO: Store the connection string somewhere more secure
        private string connString = "Server=tcp:recipe-db-server.database.windows.net,1433;Initial Catalog=recipe-db-instance;Persist Security Info=False;User ID=recipe-db-admin;Password=AkcvW4aZ28hY843#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=90;";

        public IDbConnection CreateConnection()
        {
            return new SqlConnection(connString);
        }
    } // end class
    
    public class DataBase
    {
        protected readonly IDapperDbConnection _dapperDbConnection;
        
        public DataBase(IDapperDbConnection dapperDbConnection)
        {
            _dapperDbConnection = dapperDbConnection; 
        } // end constructor

        
        
        public static string BuildQuery(string queryName, List<QueryArguments> arguments)
        {
            var query = string.Format("EXEC {0}", queryName);

            foreach (var arg in arguments)
            {
                if (!string.IsNullOrEmpty(arg.Value))
                {
                    var value = arg.IsInt
                        ? arg.Value
                        : $"'{arg.Value}'";
                    
                    query = $"{query} @{arg.Name} = {value},";
                }
            }

            return query.TrimEnd(',');
        } // end
        
        public class QueryArguments
        {
            public QueryArguments(string name, string value, bool isInt)
            {
                Name = name;
                Value = value;
                IsInt = isInt;
            }
            public string Name { get; set; }
            public string Value { get; set; }
            public bool IsInt { get; set; }
        } // end nested class
    } // end class
} // end namespace