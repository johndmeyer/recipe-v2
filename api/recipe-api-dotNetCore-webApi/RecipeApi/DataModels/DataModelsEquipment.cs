namespace DataModels
{
    public class DataModelsEquipment
    {
        /// <summary>
        /// Recipe Equipment Data Model Object
        /// </summary>
        public class Equipment
        {
            public int EquipmentId { get; set; }

            public int EquipmentIdParent { get; set; }

            public string? EquipmentName { get; set; }

            public string? EqupmentDescription { get; set; }

            public string? EquipmentPhotoUrl { get; set; }
        } // end
    } // end class
} // end namespace
