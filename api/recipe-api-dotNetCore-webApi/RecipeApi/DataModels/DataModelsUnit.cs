namespace DataModels
{
    /// <summary>
    /// Response Object Containing List Of Unit Type Data Model Objects
    /// </summary>
    public class ResponseObjectListUnitType
    {
        public IEnumerable<UnitType> UnitTypes { get; set; } = new List<UnitType>();
    } // end
    
    /// <summary>
    /// Response Object Containing List Of Unit Data Model Objects
    /// </summary>
    public class ResponseObjectListUnit
    {
        public IEnumerable<Unit> Units { get; set; } = new List<Unit>();
    } // end
    
    /// <summary>
    /// Recipe Ingredient Unit Type Data Model Object
    /// </summary>
    public class UnitType
    {
        public int UnitTypeId { get; set; }
        
        public int UnitTypeName { get; set; }
    } // end class
    
    /// <summary>
    /// Recipe Ingredient Units Data Model Object
    /// </summary>
    public class Unit : UnitType
    {
        public int UnitId { get; set; }
        
        public int UnitName { get; set; }
        
        public string UnitAbbreviation { get; set; }
    } // end class
} // end namespace