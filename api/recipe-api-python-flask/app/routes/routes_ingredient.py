from flask import request
from flask_restx import fields, Namespace, Resource
from ..data.mysql_utils import call_proc
from ..models.models_ingredient import ingredient

api = Namespace('ingredient', description='Operations on the ingredient table')

model_ingredient = ingredient(api)

getIngredient_model = api.model('data', {
	'ingredient': fields.List(fields.Nested(model_ingredient))
})

@api.route('')
class Ingredient(Resource):
	@api.doc(description='Retrieves a list of ingredient')
	@api.doc(model=getIngredient_model)
	def get(self):
		pass

	@api.doc(description='Creates a new ingredient')
	@api.doc(model=getIngredient_model)
	def put(self):
		pass

	@api.doc(description='Updates an existing ingredient')
	@api.doc(model=getIngredient_model)
	def post(self):
		pass

@api.route('/<id>')
class IngredientId(Resource):
	@api.doc(description='Deletes a specific ingredient by id')
	@api.doc(model=getIngredient_model)
	def delete(self, id):
		pass