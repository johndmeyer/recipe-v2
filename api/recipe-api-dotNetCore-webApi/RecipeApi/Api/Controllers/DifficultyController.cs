using DataModels;
using Logic;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [ApiController]
    public class DifficultyController : ControllerBase
    {
        private readonly ILogicDifficulty _logicDifficulty;

        public DifficultyController(ILogicDifficulty logicDifficulty)
        {
            _logicDifficulty = logicDifficulty;
        } // end constructor

        [HttpGet]
        [Route("difficulty")]
        public ActionResult<ResponseObject<ResponseObjectListDifficulty>> RetrieveDifficultys()
        {
            // TODO: input validation
            
            var response = _logicDifficulty.RetrieveDifficulties();
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace

