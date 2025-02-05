using Microsoft.AspNetCore.Mvc;
using DataModels;
using Logic;

namespace Api.Controllers
{
    [ApiController]
    public class RecipeController : ControllerBase
    {
        private readonly ILogicRecipe _logicRecipe;

        public RecipeController(ILogicRecipe logicRecipe)
        {
            _logicRecipe = logicRecipe;
        } // end constructor
        
        [HttpPut]
        [Route("recipe")]
        public ActionResult<ResponseObject<ResponseObjectRecipeFull>> CreateRecipe(RecipeFull recipe)
        {
            // TODO: input validation
            
            var response = _logicRecipe.CreateRecipe(recipe);
            
            return StatusCode(response.Error?.StatusCode ?? 201, response);
        } // end        
        
        [HttpDelete]
        [Route("recipe/{recipeId}")]
        public ActionResult<ResponseObject<object>> DeleteRecipe(int recipeId)
        {
            // TODO: input validation
            
            var response = _logicRecipe.DeleteRecipe(recipeId);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
        
        [HttpGet]
        [Route("recipe/{recipeId}")]
        public ActionResult<ResponseObject<ResponseObjectRecipeFull>> RetrieveRecipe(int recipeId)
        {
            // TODO: input validation

            var response = _logicRecipe.RetrieveRecipe(recipeId);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
        
        [HttpGet]
        [Route("recipe")]
        public ActionResult<ResponseObject<ResponseObjectListRecipeBase>> RetrieveRecipes(int? recipeDuration, int? recipeDifficultyId, int? recipeTagId)
        {
            // TODO: input validation
            
            var response = _logicRecipe.RetrieveRecipes(recipeDifficultyId, recipeDuration, recipeTagId);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
        
        [HttpPost]
        [Route("recipe")]
        public ActionResult<ResponseObject<ResponseObjectRecipeFull>> UpdateRecipe(RecipeFull recipe)
        {
            // TODO: input validation
            
            var response = _logicRecipe.UpdateRecipe(recipe);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace
