from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.models_equipment import equipment

api = Namespace('equpment', description='Operations on the equpment table')

model_equipment = equipment(api)

getEquipment_model = api.model('data', {
	'equipment': fields.List(fields.Nested(model_equipment))
})

@api.route('')
class Equipment(Resource):
	@api.doc(description='Retrieves a list of equipment')
	@api.doc(model=getEquipment_model)
	def get(self):
		pass

	@api.doc(description='Creates a new equipment')
	@api.doc(model=getEquipment_model)
	def put(self):
		pass

	@api.doc(description='Updates an existing equipment')
	@api.doc(model=getEquipment_model)
	def post(self):
		pass

@api.route('/<id>')
class EquipmentId(Resource):
	@api.doc(description='Deletes a specific equipment by id')
	@api.doc(model=getEquipment_model)
	def delete(self, id):
		pass