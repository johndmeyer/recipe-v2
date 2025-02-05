using DataModels;
using Logic;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [ApiController]
    public class EquipmentController : ControllerBase
    {
        private readonly ILogicEquipment _logicEquipment;

        public EquipmentController(ILogicEquipment logicEquipment)
        {
            _logicEquipment = logicEquipment;
        } // end constructor

        [HttpPut]
        [Route("equipment")]
        public ActionResult<ResponseObject<ResponseObjectEquipment>> CreateEquipment(Equipment equipment)
        {
            // TODO: input validation

            var response = _logicEquipment.CreateEquipment(equipment);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpDelete]
        [Route("equipment/{equipmentId}")]
        public ActionResult<ResponseObject<object>> DeleteEquipment(int equipmentId)
        {
            // TODO: input validation

            var response = _logicEquipment.DeleteEquipment(equipmentId);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpGet]
        [Route("equipment")]
        public ActionResult<ResponseObject<ResponseObjectListEquipment>> RetrieveEquipments()
        {
            // TODO: input validation

            var response = _logicEquipment.RetrieveEquipments();
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end

        [HttpPost]
        [Route("equipment")]
        public ActionResult<ResponseObject<ResponseObjectEquipment>> UpdateEquipment(Equipment equipment)
        {
            // TODO: input validation

            var response = _logicEquipment.UpdateEquipment(equipment);
            
            return StatusCode(response.Error?.StatusCode ?? 200, response);
        } // end
    } // end class
} // end namespace

