using Data;
using DataModels;

namespace Logic
{
    public interface ILogicUnit
    {
        ResponseObject<ResponseObjectListUnit> RetrieveUnits(string unitTypeName);
        ResponseObject<ResponseObjectListUnitType> RetrieveUnitTypes();
    } // end interface

    public class LogicUnit(IDataUnit dataUnit) : LogicBase, ILogicUnit
    {
        public ResponseObject<ResponseObjectListUnit> RetrieveUnits(string unitTypeName)
        {
            try
            {
                return new ResponseObject<ResponseObjectListUnit>
                {
                    Data = new ResponseObjectListUnit
                    {
                        Units = dataUnit.RetrieveUnits(unitTypeName).Result
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListUnit>(e);
            }
        } // end
        
        public ResponseObject<ResponseObjectListUnitType> RetrieveUnitTypes()
        {
            try
            {
                return new ResponseObject<ResponseObjectListUnitType>
                {
                    Data = new ResponseObjectListUnitType
                    {
                        UnitTypes = dataUnit.RetrieveUnitTypes().Result
                    }
                };
            }
            catch (Exception e)
            {
                return BuildErrorObject<ResponseObjectListUnitType>(e);
            }
        } // end
    } // end class
} // end namespace