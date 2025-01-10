from flask import request
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
		data['equipments'] = result[2]
		data['tags'] = result[3]

		response = {}
		response['data'] = data

		return response

class Recipes(Resource):
	def get(self):
		proc_name = 'retrieveRecipes'
		proc_args = [
			{'arg_name': 'recipeCookTime', 'arg_value': request.args.get('recipeCookTime', None)},
			{'arg_name': 'recipeDifficultyId', 'arg_value': request.args.get('recipeDifficultyId', None)},
			{'arg_name': 'recipeTagId', 'arg_value': request.args.get('recipeTagId', None)}
		]

		result = call_proc(proc_args, proc_name)

		data = {}

		data['recipes'] = result[0]

		response = {}
		response['data'] = data

		return response