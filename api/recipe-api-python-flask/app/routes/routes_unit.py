from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.models_unit import unit

api = Namespace('unit', description='Operations on the unit table')

model_unit = unit(api)

getUnits_model = api.model('data', {
	'unit': fields.List(fields.Nested(model_unit))
})

@api.route('')
class Unit(Resource):
	@api.doc(description='Retrieves a list of unit')
	@api.doc(model=getUnits_model)
	def get(self):
		pass

@api.route('/<unitTypeName>')
class EquipmentId(Resource):
	@api.doc(description='Gets units of a specific type')
	@api.doc(model=getUnits_model)
	def get(self, id):
		pass