from flask_restful import Resource
from data.request import exec

class Recipe(Resource):
	def get(self, id):
		proc_name = 'retrieveRecipe'
		proc_args = [
			{'arg_name': 'recipeId', 'arg_value': id}
		]

		return exec(proc_name, proc_args)