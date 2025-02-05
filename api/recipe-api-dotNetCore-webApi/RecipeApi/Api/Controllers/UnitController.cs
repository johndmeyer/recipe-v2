using DataModels;
using Logic;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [ApiController]
    public class UnitController : ControllerBase
    {
        private readonly ILogicUnit _logicUnit;

        public UnitController(ILogicUnit logicUnit)
        {
            _logicUnit = logicUnit;
        }

        [HttpGet]
        [Route("unit/{unitTypeName}")]
        public ActionResult<ResponseObject<ResponseObjectListUnit>> RetrieveUnits(string unitTypeName)
        {
            // TODO: input validation

            var response = _logicUnit.RetrieveUnits(unitTypeName);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpGet]
        [Route("unit")]
        public ActionResult<ResponseObject<ResponseObjectListUnitType>> RetrieveUnitTypes()
        {
            // TODO: input validation

            var response = _logicUnit.RetrieveUnitTypes();
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace

