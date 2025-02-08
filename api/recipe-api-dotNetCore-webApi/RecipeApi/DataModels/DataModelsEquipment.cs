namespace DataModels
{
    /// <summary>
    /// Response Object Containing Equipment Data Model Object
    /// </summary>
    public class ResponseObjectEquipment
    {
        public Equipment? Equipment { get; set; }
    } // end

    /// <summary>
    /// Response Object Containing List Of Equipment Data Model Objects
    /// </summary>
    public class ResponseObjectListEquipment
    {
        public IEnumerable<Equipment> Equipments { get; set; } = new List<Equipment>();
    } // end
    
    /// <summary>
    /// Recipe Equipment Data Model Object
    /// </summary>
    public class Equipment
    {
        public int EquipmentId { get; set; }

        public int? EquipmentIdParent { get; set; }

        public string EquipmentName { get; set; }

        public string? EquipmentDescription { get; set; }

        public string? EquipmentPhotoUrl { get; set; }
        
        public IEnumerable<Equipment> Items { get; set; }
    } // end class
} // end namespace
