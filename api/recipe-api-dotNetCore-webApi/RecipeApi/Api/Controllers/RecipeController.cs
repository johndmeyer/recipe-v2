using Microsoft.AspNetCore.Mvc;
using DataModels;
using Logic;

namespace RecipeApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RecipeController : ControllerBase
    {
        private readonly ILogger<RecipeController> _logger;

        private readonly ILogicRecipe _logicRecipe;

        public RecipeController(
            ILogger<RecipeController> logger,
            ILogicRecipe logicRecipe)
        {
            _logger = logger;

            _logicRecipe = logicRecipe;
        } // end controller

        [HttpGet]
        [Route("/")]
        public IEnumerable<DataModelsRecipe.RecipeBase> RetrieveRecipes()
        {
            try
            {
                return _logicRecipe.RetrieveRecipes(null, null, null).ToList();
            }
            catch (Exception)
            {
                // TODO: Configure exception logging
                return null;
            }
        } // end

        [HttpGet]
        [Route("/{recipeId}")]
        public DataModelsRecipe.RecipeFull RetrieveRecipe(int recipeId)
        {
            try
            {
                return new DataModelsRecipe.RecipeFull();
            }
            catch (Exception)
            {
                // TODO: Configure exception logging
                return null;
            }
        } // end
    } // end class
} // end namespace
