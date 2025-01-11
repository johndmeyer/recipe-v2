using static DataModels.DataModelsRecipe;

namespace Logic
{
    public interface ILogicRecipe
    {
        IEnumerable<RecipeBase> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId);

        RecipeFull RetrieveRecipe();

        void DeleteRecipe();
    } // end interface
} // end namespace
