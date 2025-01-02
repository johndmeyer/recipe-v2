from flask_restful import Resource
from data.mysql_utils import call_proc

class Recipe(Resource):
	def get(self, id):
		proc_name = 'retrieveRecipe'
		proc_args = [
			{'arg_name': 'recipeId', 'arg_value': id}
		]

		result = call_proc(proc_args, proc_name)

		data = {}

		data['recipe'] = result[0][0]
		data['ingredients'] = result[1]

		response = {}

		response['data'] = data

		return response

