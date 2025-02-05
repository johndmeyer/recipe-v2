using DataModels;
using Logic;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [ApiController]
    public class IngredientController : ControllerBase
    {
        private readonly ILogicIngredient _logicIngredient;

        public IngredientController(ILogicIngredient logicIngredient)
        {
            _logicIngredient = logicIngredient;
        }

        [HttpPut]
        [Route("ingredient")]
        public ActionResult<ResponseObject<ResponseObjectIngredientBase>> CreateIngredient(IngredientBase ingredient)
        {
            // TODO: input validation

            var response = _logicIngredient.CreateIngredient(ingredient);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpDelete]
        [Route("ingredient/{ingredientId}")]
        public ActionResult<ResponseObject<object>> DeleteIngredient(int ingredientId)
        {
            // TODO: input validation

            var response = _logicIngredient.DeleteIngredient(ingredientId);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpGet]
        [Route("ingredient")]
        public ActionResult<ResponseObject<ResponseObjectListIngredientBase>> RetrieveIngredients()
        {
            // TODO: input validation

            var response = _logicIngredient.RetrieveIngredients();
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpPost]
        [Route("ingredient")]
        public ActionResult<ResponseObject<ResponseObjectIngredientBase>> UpdateIngredient(IngredientBase ingredient)
        {
            // TODO: input validation

            var response = _logicIngredient.UpdateIngredient(ingredient);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace

