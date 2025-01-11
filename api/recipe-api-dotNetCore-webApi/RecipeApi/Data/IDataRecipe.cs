using static DataModels.DataModelsRecipe;

namespace Data
{
    public interface IDataRecipe
    {
        Task<IEnumerable<RecipeBase>> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId);
    } // end interface
} // end namespace