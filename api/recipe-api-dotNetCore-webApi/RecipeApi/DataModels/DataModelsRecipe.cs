using static DataModels.DataModelsEquipment;
using static DataModels.DataModelsIngredient;
using static DataModels.DataModelsTag;

namespace DataModels
{
    public class DataModelsRecipe
    {
        /// <summary>
        /// Base Recipe Data Model Object
        /// Used in results table
        /// </summary>
        public class RecipeBase : DataModelsBase
        {
            public int RecipeId { get; set; }

            public int RecipeCookTime { get; set; }

            public string? RecipeDescription { get; set; }

            public int RecipeDifficultyId { get; set; }

            public string? RecipeDirections { get; set; }

            public string? RecipeName { get; set; }

            public string? RecipePhotoUrl { get; set; }

            public int RecipeYield { get; set; }

        } // end

        /// <summary>
        /// Full Recipe Data Model Object
        /// </summary>
        public class RecipeFull : DataModelsBase
        {
            public RecipeBase? Recipe { get; set; }

            public IEnumerable<Equipment>? Equipments { get; set; }

            public IEnumerable<IngredientFull>? Ingredients { get; set; }

            public IEnumerable<Tag>? Tags { get; set; }

        } // end
    } // end class
} // end namespace
