using DataModels;
using Logic;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [ApiController]
    public class DurationController : ControllerBase
    {
        private readonly ILogicDuration _logicDuration;

        public DurationController(ILogicDuration logicDuration)
        {
            _logicDuration = logicDuration;
        }

        [HttpGet]
        [Route("duration")]
        public ActionResult<ResponseObject<ResponseObjectListDuration>> RetrieveDurations()
        {
            // TODO: input validation

            var response = _logicDuration.RetrieveDurations();
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace

