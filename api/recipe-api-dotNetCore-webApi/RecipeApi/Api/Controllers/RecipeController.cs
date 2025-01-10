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
        }

        [HttpGet(Name = "RetrieveRecipes")]
        public IEnumerable<DataModelsRecipe.RecipeBase> Get()
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
        }
    }
}
