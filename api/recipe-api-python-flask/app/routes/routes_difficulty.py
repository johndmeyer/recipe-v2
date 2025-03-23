from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.models_difficulty import difficulty

api = Namespace('difficulty', description='Operations on the difficulty table')

model_difficulty = difficulty(api)

getDifficulties_model = api.model('data', {
	'difficulties': fields.List(fields.Nested(model_difficulty))
})

@api.route('')
class Difficulty(Resource):
	@api.doc(description='Retrieves a list of difficulty levels')
	@api.doc(model=getDifficulties_model)
	def get(self):
		proc_name = 'retrieveDifficulties'
		proc_args = []

		result = call_proc(proc_args, proc_name)

		data = {}

		data['difficultys'] = result[0]

		response = {}
		response['data'] = data

		return response
