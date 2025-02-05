namespace DataModels
{
    /// <summary>
    /// Response Object Containing Full Recipe Data Model Object
    /// </summary>
    public class ResponseObjectIngredientBase
    {
        public IngredientBase? Ingredient { get; set; }
    } // end

    /// <summary>
    /// Response Object Containing List Of Base Ingredient Data Model Objects
    /// </summary>
    public class ResponseObjectListIngredientBase
    {
        public IEnumerable<IngredientBase> Ingredients { get; set; } = new List<IngredientBase>();
    } // end
    
    /// <summary>
    /// Base Ingredient Data Model Object
    /// Used for drop-downs and ref table edit
    /// </summary>
    public class IngredientBase
    {
        public int IngredientId { get; set; }

        public int IngredientIdParent { get; set; }

        public string? IngredientDescription { get; set; }

        public string? IngredientName { get; set; }

        public string? IngredientPhotoUrl { get; set; }
    } // end class

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
    } // end class
} // end namespace
