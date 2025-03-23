from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.models_equipment import equipment
from ..models.models_ingredient import ingredient
from ..models.models_recipe import recipe
from ..models.models_tag import tag

api = Namespace('recipe', description='Operations on the recipe and associated tables')

model_equipment = equipment(api)
model_ingredient = ingredient(api)
model_recipe =  recipe(api)
model_tag = tag(api)

getRecipes_model = api.model('data', {
	'recipes': fields.List(fields.Nested(model_recipe))
})

@api.route('')
class Recipe(Resource):
	@api.doc(description='Retrieves a list of recipes filtered by the input criteria')
	@api.doc(model=getRecipes_model)
	def get(self):
		proc_name = 'retrieveRecipes'
		proc_args = [
			{'arg_name': 'recipeCookTime', 'arg_value': request.args.get('recipeCookTime', 0, int)},
			{'arg_name': 'recipeDifficultyId', 'arg_value': request.args.get('recipeDifficultyId', 0, int)},
			{'arg_name': 'recipeTagId', 'arg_value': request.args.get('recipeTagId', 0, int)}
		]

		result = call_proc(proc_args, proc_name)

		data = {}

		data['recipes'] = result[0]

		response = {}
		response['data'] = data

		return response
	
	@api.doc(description='Creates a new recipe and associated entries in the equipment, ingredient, and tag tables')
	@api.doc(model=getRecipes_model)
	def post(self):
		pass

	@api.doc(description='Updates an existing recipe and associated entries in the equipment, ingredient, and tag tables')
	@api.doc(model=getRecipes_model)
	def put(self):
		pass

getRecipe_model = api.model('data', {
	'equipments': fields.List(fields.Nested(model_equipment)),
	'ingredients': fields.List(fields.Nested(model_ingredient)),
	'recipe': fields.Nested(model_recipe),
	'tags': fields.List(fields.Nested(model_tag))
})

@api.route('/<id>')
class Recipe(Resource):
	@api.doc(params={'id': 'The id of the recipe to be returned'})
	@api.doc(description='Retrieves a recipe by id')
	@api.doc(model=getRecipe_model)
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

	@api.doc(params={'id': 'The id of the recipe to be deleted'})
	@api.doc(description='Deletes entry from the recipe table as well as associated entries in the equipment, ingredient, and tag tables')
	def delete(self, id):
		pass

