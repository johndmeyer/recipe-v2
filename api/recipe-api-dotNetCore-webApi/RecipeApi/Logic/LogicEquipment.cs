using Data;
using DataModels;

namespace Logic
{
    public interface ILogicEquipment
    {
        ResponseObject<ResponseObjectEquipment> CreateEquipment(Equipment equipment);
        ResponseObject<object> DeleteEquipment(int equipmentId);
        ResponseObject<ResponseObjectListEquipment> RetrieveEquipments();
        ResponseObject<ResponseObjectEquipment> UpdateEquipment(Equipment equipment);
    } // end interface

    public class LogicEquipment(IDataEquipment dataEquipment) : LogicBase, ILogicEquipment
    {
        public ResponseObject<ResponseObjectEquipment> CreateEquipment(Equipment equipment)
        {
            try
            {
                return new ResponseObject<ResponseObjectEquipment>
                {
                    Data = new ResponseObjectEquipment
                    {
                        Equipment = dataEquipment.CreateEquipment(equipment).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectEquipment>(e);
            }
        } // end
        
        public ResponseObject<object> DeleteEquipment(int equipmentId)
        {
            try
            {
                dataEquipment.DeleteEquipment(equipmentId);
                
                return new ResponseObject<object>();
            }
            catch (Exception e)
            {
                return BuildErrorObject<object>(e);
            }
        } // end
        
        public ResponseObject<ResponseObjectListEquipment> RetrieveEquipments()
        {
            try
            {
                var equipments = dataEquipment.RetrieveEquipments().Result;
                return new ResponseObject<ResponseObjectListEquipment>
                {
                    Data = new ResponseObjectListEquipment
                    {
                        Equipments = BuildObjectTree(equipments.ToList())
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListEquipment>(e);
            }
        } // end
        
        public ResponseObject<ResponseObjectEquipment> UpdateEquipment(Equipment equipment)
        {
            try
            {
                return new ResponseObject<ResponseObjectEquipment>
                {
                    Data = new ResponseObjectEquipment
                    {
                        Equipment = dataEquipment.UpdateEquipment(equipment).Result.FirstOrDefault()
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectEquipment>(e);
            }
        } // end
    } // end class
} // end namespace