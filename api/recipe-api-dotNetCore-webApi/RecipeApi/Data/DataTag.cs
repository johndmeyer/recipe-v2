using DataModels;
using Dapper;

namespace Data
{
    public interface IDataTag
    {
        Task<IEnumerable<Tag>> CreateTag(Tag tag);
        void DeleteTag(int tagId);
        Task<IEnumerable<Tag>> RetrieveTags();
        Task<IEnumerable<Tag>> UpdateTag(Tag tag);
    } // end interface
    
    public class DataTag(IDapperDbConnection dapperDbConnection) : DataBase(dapperDbConnection), IDataTag
    {
        public async Task<IEnumerable<Tag>> CreateTag(Tag tag)
        {
            var queryName = "createTag";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "TagParentId", value: tag.TagIdParent.ToString() ?? "", isInt: true),
                new QueryArguments(name: "TagName", value: tag.TagName, isInt: false),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Tag>(query);
            }
        } // end

        public async void DeleteTag(int tagId)
        {
            var queryName = "deleteTag";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "TagId", value: tagId.ToString(), isInt: true)
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<object>(query);
            }
        } // end

        public async Task<IEnumerable<Tag>> RetrieveTags()
        {
            var queryName = "retrieveTags";
            var arguments = new List<QueryArguments>();
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Tag>(query);
            }
        } // end

        public async Task<IEnumerable<Tag>> UpdateTag(Tag tag)
        {
            var queryName = "updateTag";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "TagId", value: tag.TagId.ToString() ?? "", isInt: true),
                new QueryArguments(name: "TagName", value: tag.TagName, isInt: false)
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Tag>(query);
            }
        } // end
    } // end class
} // end namespace
