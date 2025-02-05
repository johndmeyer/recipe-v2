using Microsoft.AspNetCore.Mvc;
using DataModels;
using Logic;

namespace Api.Controllers
{
    [ApiController]
    public class TagController : ControllerBase
    {
        private readonly ILogicTag _logicTag;

        public TagController(ILogicTag logicTag)
        {
            _logicTag = logicTag;
        } // end controller

        [HttpPut]
        [Route("tag")]
        public ActionResult<ResponseObject<ResponseObjectTag>> CreateTag(Tag tag)
        {
            // TODO: input validation

            var response = _logicTag.CreateTag(tag);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpDelete]
        [Route("tag/{tagId}")]
        public ActionResult<ResponseObject<object>> DeleteTag(int tagId)
        {
            // TODO: input validation

            var response = _logicTag.DeleteTag(tagId);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpGet]
        [Route("tag")]
        public ActionResult<ResponseObject<ResponseObjectListTag>> RetrieveTags()
        {
            // TODO: input validation

            var response = _logicTag.RetrieveTags();
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpPost]
        [Route("tag")]
        public ActionResult<ResponseObject<ResponseObjectTag>> UpdateTag(Tag tag)
        {
            // TODO: input validation

            var response = _logicTag.UpdateTag(tag);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace

