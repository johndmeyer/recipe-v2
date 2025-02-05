namespace DataModels
{
    /// <summary>
    /// Response Object Containing Full Recipe Data Model Object
    /// </summary>
    public class ResponseObjectRecipeFull
    {
        public RecipeFull? Recipe { get; set; }
    } // end

    /// <summary>
    /// Response Object Containing List Of Base Recipe Data Model Objects
    /// </summary>
    public class ResponseObjectListRecipeBase
    {
        public IEnumerable<RecipeBase> Recipes { get; set; } = new List<RecipeBase>();
    } // end
    
    /// <summary>
    /// Base Recipe Data Model Object
    /// </summary>
    public class RecipeBase
    {
        public int RecipeId { get; set; }
        
        public required string RecipeDescription { get; set; }

        public required int RecipeDifficultyId { get; set; }

        public required string RecipeDirections { get; set; }
        
        public required int RecipeDuration { get; set; }

        public required string RecipeName { get; set; }

        public required string RecipePhotoUrl { get; set; }

        public required int RecipeYield { get; set; }
    } // end class

    /// <summary>
    /// Full Recipe Data Model Object
    /// </summary>
    public class RecipeFull
    {
        public required RecipeBase Recipe { get; set; }

        public required IEnumerable<Equipment> RecipeEquipments { get; set; }

        public required IEnumerable<IngredientFull> RecipeIngredients { get; set; }

        public required IEnumerable<Tag> RecipeTags { get; set; }
    } // end class
} // end namespace
