using DataModels;
using Dapper;

namespace Data
{
    public interface IDataEquipment
    {
        Task<IEnumerable<Equipment>> CreateEquipment(Equipment equipment);
        void DeleteEquipment(int equipmentId);
        Task<IEnumerable<Equipment>> RetrieveEquipments();
        Task<IEnumerable<Equipment>> UpdateEquipment(Equipment equipment);
    } // end interface
    
    public class DataEquipment(IDapperDbConnection dapperDbConnection) : DataBase(dapperDbConnection), IDataEquipment
    {
        public async Task<IEnumerable<Equipment>> CreateEquipment(Equipment equipment)
        {
            var queryName = "createEquipment";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "equipmentParentId", value: equipment.EquipmentIdParent.ToString(), isInt: true),
                new QueryArguments(name: "equipmentName", value: equipment.EquipmentName, isInt: false),
                new QueryArguments(name: "equipmentDescription", value: equipment.EquipmentDescription, isInt: false),
                new QueryArguments(name: "equipmentPhotoUrl", value: equipment.EquipmentPhotoUrl, isInt: false),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Equipment>(query);
            }
        } // end

        public async void DeleteEquipment(int equipmentId)
        {
            var queryName = "deleteEquipment";
            var arguments = new List<QueryArguments>
            {
                new QueryArguments(name: "equipmentId", value: equipmentId.ToString(), isInt: true)
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                await connection.QueryAsync<object>(query);
            }
        } // end

        public async Task<IEnumerable<Equipment>> RetrieveEquipments()
        {
            var queryName = "retrieveEquipments";
            var arguments = new List<QueryArguments>();
            
            var query = BuildQuery(queryName, arguments);

            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Equipment>(query);
            }
        } // end

        public async Task<IEnumerable<Equipment>> UpdateEquipment(Equipment equipment)
        {
            var queryName = "updateEquipment";
            var arguments = new List<QueryArguments>()
            {
                new QueryArguments(name: "equipmentId", value: equipment.EquipmentId.ToString(), isInt: true),
                new QueryArguments(name: "equipmentName", value: equipment.EquipmentName, isInt: false),
                new QueryArguments(name: "equipmentDescription", value: equipment.EquipmentDescription, isInt: false),
                new QueryArguments(name: "equipmentPhotoUrl", value: equipment.EquipmentPhotoUrl, isInt: false),
            };
            
            var query = BuildQuery(queryName, arguments);
            
            using (var connection = _dapperDbConnection.CreateConnection())
            {
                return await connection.QueryAsync<Equipment>(query);
            }
        } // end
    } // end class
} // end namespace
