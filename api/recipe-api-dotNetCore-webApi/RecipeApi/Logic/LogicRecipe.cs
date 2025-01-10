using Data;
using static DataModels.DataModelsRecipe;

namespace Logic
{
    public class LogicRecipe : ILogicRecipe
    {
        private readonly IDataRecipe _dataRecipe;

        // Constructor
        public LogicRecipe(IDataRecipe dataRecipe)
        {
            _dataRecipe = dataRecipe;
        }

        public IEnumerable<RecipeBase> RetrieveRecipes(int? recipeCookTime, int? recipeDifficultyId, int? recipeTagId)
        {
            // This is currently just a pass through tier, but if we wanted more complex logic this is where it would go
            return _dataRecipe.RetrieveRecipes(recipeCookTime, recipeDifficultyId, recipeTagId).Result;
        }

        public RecipeFull RetrieveRecipe()
        {
            return new RecipeFull();
        }

        public void DeleteRecipe()
        {

        }
    }
}
