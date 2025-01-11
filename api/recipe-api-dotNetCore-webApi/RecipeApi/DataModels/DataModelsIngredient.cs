namespace DataModels
{
    public class DataModelsIngredient
    {
        /// <summary>
        /// Base Ingredient Data Model Object
        /// Used for drop downs and ref table edit
        /// </summary>
        public class IngredientBase : DataModelsBase
        {
            public int IngredientId { get; set; }

            public int IngredientIdParent { get; set; }

            public string? IngredientDescription { get; set; }

            public string? IngredientName { get; set; }

            public string? IngredientPhotoUrl { get; set; }
        } // end 

        /// <summary>
        /// Full Ingredient Data Model Object
        /// </summary>
        public class IngredientFull : IngredientBase
        {
            public int Quantity { get; set; }

            public int UnitId { get; set; }

            public string? UnitName { get; set; }

            public int UnitTypeId { get; set; }

            public string? UnitTypeName { get; set; }

            public string? UnitAbbreviation { get; set; }
        } // end
    } // end class
} // end namespace
